<h2> Summary </h2>

<h5> This application has 3 parts </h5>


* Okta (./Okta): Utilized to setup okta with... 
    * 2 Users
    * 2 developer groups, eaching having a user assigned from above
    * 2 OIDC applications for the dev users/groups above (one group to one Developer OIDC client app)
    * 3 client applications to represent 3 different microservices (client type: API/Service)
    * 2 authorizations servers that have a mix of allowed clients 
        * AS1 allows clients: Service_A, Service_B & DevGroup1
        * AS2 allows clients: Service_B, Service_C & DevGroup2   
   <br>
* Resource Server (./Test_Resource):
    * Takes a GET request at "/" to validate access tokens passed via the Authorization Header "Authorization: Bearer {accesstoken}"
    * Will return data within the sent access token and 200 HTTP code if Valid
    * By Default this resource accepts 'Audiance' claim of 'Resource1' which is served by AS1
        * AS2 will serve an 'Audiance' claim of 'Resource2'
        * This is configurable on Test_Resource Server by setting the 'AUDIANCE' environment variable 
   <br>
* Client (./Test_Client):
    * Will request access tokens using Client Credential flow and pass them to above resource server for validation. It will wait 60 seconds inbetween request and try again. Token lifetime is set to 5 min per authorization server settings in ./Okta TF. Upon the 5th request to the above resource the request will fail, request a new access token from the authorization server, and then request the resource again.
    * Client will console log the returned info from the Resource Server if the access token is valid


<h2> How do I get set up?</h2>

<h5> Setup Okta: </h5>

* Get a okta developer account - https://developer.okta.com/signup/ Select "Workforce Identity Cloud - Free"
   * Create an okta API Key:  Security -> API -> Tokens
* Set your okta env vars as shown in the tf providers file in the terraform/okta directory
* terraform init && terraform apply
* Terraform should output all the info you need to run your test
    * AuthServer  1 & 2 details
    * Service A, B & C details 
    * DevGroup 1 & 2 details
    * User 1 & 2 details
* For the sensitive values run the following command
    * terraform output -raw "TF Object" 
    * e.g. terraform output -raw DevGroup_1_Client_Secret
 
<h5> Test client_credential flow:</h5>

* Resource Server:
   * cd ./Test_Resource && npm install
   * Start the Resource Server which will validate access tokens ./Test_Resource
   * Ensure you environment vars are set to you enviornment as example shown below (see your TF Output)
        * export AUTH_SERVER=https://dev-12345678.okta.com/oauth2/aus6oKFI4K49FK4KFI 
        * export AUDIANCE=Resource1
    * Run the Resource Server
        * Test_Resource % AUTH_SERVER='https://dev-12345678.okta.com/oauth2/aus6oKFI4K49FK4KFI' AUDIANCE='Resource1' node index.js
   
* Client:
    * cd ./Test_Resource && npm install
    * Start the client which will get tokens from your authorization server and send to the above resource for validation ./Test_Client
    * The Client is utilizing a Client ID & Secret which is combined as base64 Client:Secret and passed via Basic Auth Header (see below)
    * Ensure you environment vars are set to you enviornment as example shown below (see your TF Output)
        * export AUTH_SERVER=https://dev-12345678.okta.com/oauth2/aus6oKFI4K49FK4KFI
        * export BASIC_AUTH=0oa6o82634bqdS3Qw5d7:HzveNodchw6xcO6eE-sTbidSDHf6SN1R7Hwq09y0
    * Run the Client
        * Test_Client % BASIC_AUTH='0oa6o82634bqdS3Qw5d7:HzveNodchw6xcO6eE-sTbidSDHf6SN1R7Hwq09y0' AUTH_SERVER='https://dev-12345678.okta.com/oauth2/aus6oKFI4K49FK4KFI' node index.js

<h5> Test Authorization Code Flow: </h5>

* Resource Server:
   * Follow steps above to start the resource server

* Resource Owner: 
   * Use a tool like postman to  perfrom 'Oauth 2.0' authorization from one of the two deployed authorizations servers.
        * set Grant Type            =  Authorization Code (PKCE)
        * set call back e.g.        =  http://localhost:8080/authorization-code/callback
        * set auth URL e.g.         =  https://dev-12345678.okta.com/oauth2/ausctaad1lxlnIonX5d7/v1/authorize
        * set acces token url e.g.  =  https://dev-12345678.okta.com/oauth2/ausctaad1lxlnIonX5d7/v1/token
        * set client ID e.g.        =  0oactaf3x4p6jshBC9d7
        * set client Secret e.g.    =  p96XQfGtpxolqWFjUk3uG4N5nJOa1uvOvM4wnF4iKw9xCGrdlKijvVxua8obNqgI
        * set Scope e.g.            =  access
        * set State e.g.            =  aaaaaaaaa
        * set Client Authenticaiton =  Send client credential in body
        * Click "Get New Access Token" 
        * Copy the returned Access token (will be a JWT token format)
     <br>
    * Send that token to the Local host Resource server
        * Ensure the Test Resource is running. See above
        * Change Authorization to "Basic Auth"
        * Paste in the JWT token that was coppied in the step above (this it time bound to only 5 minutes of validity)
        * Send a GET request to the Test Resource server
            * GET http://localhost:3000
        * You should get a 200 response and also see the call on the terminal running the test resource!
     <br>
     
    * Things to Test:
        * Try changing to the other Authorization Server (validate allowed clients / auth server access policy)
        * Try changing the Audiance value (validate Resource Server Oauth Validation)
        * Try changing the scope (validate auth server access policy and allowed scopes)
        * Try sending an invalid JWT to the Resource Server (validate Resource Server Oauth Validation)
            
            
<h3> ToDo: </h3>

Contact: chiefriver@chiefriver.com
