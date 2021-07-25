import ballerina/encoding;
import ballerina/http;

# The Twitter client object.
public type Client client object {

    http:Client twitterClient;
    Credential twitterCredential;

    public function __init(Configuration twitterConfig) {
        self.twitterClient = new(TWITTER_API_URL, twitterConfig.clientConfig);
        self.twitterCredential = {
            accessToken: twitterConfig.accessToken,
            accessTokenSecret: twitterConfig.accessTokenSecret,
            consumerKey: twitterConfig.consumerKey,
            consumerSecret: twitterConfig.consumerSecret
        };
    }

    # Updates the authenticating user's current status, also known as Tweeting.
    #
    # + status - The text of status update
    # + return - If success, returns `twitter:Status` object, else returns `error`
    public remote function tweet(string status) returns @tainted Status|error {
        // Build the HTTP request with the authentication information required by Twitter REST API.
        var encodedStatus = encoding:encodeUriComponent(status, UTF_8);
        if (encodedStatus is error) {
            return prepareError("Error occurred while encoding the status.");
        }
        string urlParams = "status=" + <string>encodedStatus;

        var header = generateAuthorizationHeader(self.twitterCredential, POST, UPDATE_API, urlParams);
        if (header is error) {
            return prepareError("Error occurred while generating authorization header.");
        }
        http:Request request = new;
        request.setHeader("Authorization", <string>header);
        string requestPath = UPDATE_API + "?" + urlParams;

        // Call the REST API to tweet.
        // Get the result of the API invocation.
        var httpResponse = self.twitterClient->post(requestPath, request);

        // If the API invocation is success, build the `Status` record and return.
        // Else, return a meaningful error.
        if (httpResponse is http:Response) {
                    var jsonPayload = httpResponse.getJsonPayload();
                    if (jsonPayload is json) {
                        int statusCode = httpResponse.statusCode;
                        if (statusCode == http:STATUS_OK) {
                            return convertToStatus(jsonPayload);
                        } else {
                            return prepareErrorResponse(jsonPayload);
                        }
                    } else {
                        return prepareError("Error occurred while accessing the JSON payload of the response.");
                    }
                } else {
                    return prepareError("Error occurred while invoking the REST API.");
                }
    }
};

type Credential record {
    string accessToken;
    string accessTokenSecret;
    string consumerKey;
    string consumerSecret;
};

# The Twitter connector configurations.
#
# + accessToken - The access token of the Twitter account
# + accessTokenSecret - The access token secret of the Twitter account
# + consumerKey - The consumer key of the Twitter account
# + consumerSecret - The consumer secret of the Twitter account
# + clientConfig - HTTP client endpoint configurations
public type Configuration record {
    string accessToken;
    string accessTokenSecret;
    string consumerKey;
    string consumerSecret;
    http:ClientConfiguration clientConfig = {};
};
