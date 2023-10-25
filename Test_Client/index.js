

function sleep(ms) {
    return new Promise((resolve) => {
      setTimeout(resolve, ms);
    });
  }


function GetToken(TokenEndpoint, Authorization, Scope) {
    console
    console.log('\n Getting a Token...')
    return new Promise((resolve, reject) => {
        var axios = require('axios');
        var qs = require('qs');
        var data = qs.stringify({
        'grant_type': 'client_credentials',
        'scope': Scope
        });
        var config = {
        method: 'post',
        url: TokenEndpoint,
        headers: { 
            'Authorization': 'Basic ' + Authorization, 
            'Content-Type': 'application/x-www-form-urlencoded'
        },
        data : data
        };

        axios(config)
        .then(function (response) {

            console.log(" Token Aquired!")
            return resolve(response)
        })
        .catch(function (error) {
            console.log("\n Failed to get Token")
            return reject(error);
        });
    });
}

function CallAPI(token, resource){
    return new Promise((resolve, reject) => {
        var axios = require('axios');

        var config = {
        method: 'get',
        url: resource,
        headers: { 
            'Authorization': 'Bearer ' + token
        }
        };
        
        axios(config)
        .then(function (response) {
            console.log("\n Successful Call to API")
            console.log(" Response Code: " + response.status + '\n');
            console.log(" Response Data:")
            console.log(" ", response.data)
            return resolve(response)
        })
        .catch(function (error) {
            console.log("\n Error Calling API")
            console.log(" " + error);
            return reject(error)
        });
    });
}



const TestTokens = async () => {
    // Set Env Vars for your microservice basic auth 'clientid:secret' 
    // export ClientIdSecret="clientid:secret"
    let ClientIdSecret = process.env.BASIC_AUTH;
    let buff = new Buffer.from(ClientIdSecret);
    let BasicAuth = buff.toString('base64');

    // A port for serving API's
    const Scope = process.env.SCOPE || 'access';
    
    // Set Env Vars for your Authorization server you wish to test' 
    // export AUTH_SERVER='https://dev-123456.okta.com/oauth2/aus6o81s7gt9dKTPh5d7'
    const TokenEndpoint = process.env.AUTH_SERVER + '/v1/token';

    // const resource = 'http://localhost:3000'
    const resource = process.env.RESOURCE_SERVER || 'http://localhost:3000'
    var CurrentToken;
    var times = 15;
    var waitTime = 60000

    console.log("")
    console.log("Scope: " + Scope)
    console.log("Auth Server: " + TokenEndpoint.split("/v1/")[0])
    console.log("ClientID: " + ClientIdSecret.split(":")[0])
    
    for(var i = 0; i < times; i++){
        
        if (!CurrentToken){
            try{
                tokenReq = await GetToken(TokenEndpoint, BasicAuth, Scope)
                CurrentToken = tokenReq.data.access_token
            }
            catch(err){
                console.log("\n Failed to get initial access Token")
                console.log("  Requested Token Endpoint: ", TokenEndpoint)
                console.log("  Requested Scope: ", Scope)
                console.log("  Error: ", err.response.data.error)
                console.log("  Error Desc.: ",err.response.data.error_description)
                return
            }
            try{
                await CallAPI(CurrentToken, resource)
            }
            catch(err){
                console.log("\n Failed to Call Resource\n")
                return

            }
          
        }
        
        else{
            console.log(" Already have token")
            try{
                await CallAPI(CurrentToken, resource)
            }
            catch(err){
                if(err.code == 'ECONNREFUSED'){
                    console.log(" Connection Refused")
                    return
                }
                else if(err.response.status == 401){
                    try{
                        console.log(" Token failed, Going to get a new Token...")
                        tokenReq = await GetToken(TokenEndpoint, BasicAuth, Scope)
                        CurrentToken = tokenReq.data.access_token
                        await CallAPI(CurrentToken, resource)
  
                    }
                    catch(err){
                        console.log(" Failed to refresh Token")
                        console.log(err)
                        return
                    }
                }
                else{
                    console.log(err.code)
                    return

                }
            } 
        } 
    
        console.log ("\n waiting " + waitTime/1000 + " seconds...\n");
        await sleep(waitTime);
    }
}          

    


TestTokens();