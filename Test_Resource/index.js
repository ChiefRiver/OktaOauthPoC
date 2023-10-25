// Import express for creating API's endpoints
const express = require('express');

////////////
// Env Vars
////////////

// Okta Auth Server Ex. "https://dev-12345678.okta.com/oauth2/aus6k5d74gt9cKTPh5d7
const OktaAuthServer = process.env.AUTH_SERVER;

// Resource Server Audiance (string or list) Ex. "api://default"
const aud = process.env.AUDIANCE || 'Resource1';

// A port for serving API's
const port = process.env.PORT || 3000;


////////////
// Okta Config
////////////
const OktaJwtVerifier = require('@okta/jwt-verifier');

const oktaJwtVerifier = new OktaJwtVerifier({
  issuer: OktaAuthServer // required
});



////////////
// Response functions
////////////

function ValidToken(jwt, res){
    console.log('');
    console.log('Token is valid, Claims Below');
    console.log(jwt.claims);

    res.json({
        Response: 'Token is valid, Claims Below',
        TokenValid: "Yes",
        Claims: jwt.claims
    });
    return jwt;
}

function InValidToken(err, res){
    console.log("");
    console.log('Token is INVALID!');
    console.log('Reason: ' +err);

    res.status(401);
    res.json({
        Response: err,
        TokenValid: "No"
    });
    return err;
}


////////////
// Express HTTP Server w/ JWT Access Token Validation
////////////


// Creates an Express application, initiate
// express top level function
const app = express();




// Listen the server
app.listen(port, () => {
    console.log("");
	console.log(`Server is running : http://localhost:${port}/`);
    console.log(`AuthSever : `+ OktaAuthServer);
    console.log(`Audiance : ` + aud );
});


// Allow json data
app.use(express.json());


// Validate Token Route
app.get('/', (req, res) => {
 
    // Get access token from the authoization header "Authorization: Bearer ..."
    const token = req.headers.authorization;
 
    // If the token is present
    if(token){
 
        const accessTokenString = token.split(" ")[1]

        // Verify the token using jwt.verify method
        oktaJwtVerifier.verifyAccessToken(accessTokenString, aud)
        .then(jwt => ValidToken(jwt, res) )
        .catch(err => InValidToken(err, res) );

        
    }else{
 
        // Return response with error
        res.status(400);
        res.json({
            Response: "No authorization token provided",
            TokenValid: "No"
        });
    }
});




/////////////////
// OKTA Verify
/////////////////


