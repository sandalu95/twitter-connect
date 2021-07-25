Twitter is what’s happening now. Twitter’s developer platform provides many API products, tools, and resources that enable you to harness the power of Twitter's open, global, and real-time communication network. This module provide capabilities to connects to Twitter from Ballerina.

# Module Overview

The Twitter connector allows you to tweet through the Twitter REST API.

**Status Operations**

The `sandalukalpanee/twitter` module contains operations that work with statuses. Status is also known as a 'Tweet'. You can update the current status.

> Twitter API: https://developer.twitter.com/en/docs/tweets/post-and-engage/overview


## Compatibility
|                    | Version                                                          |
|:------------------:|:----------------------------------------------------------------:|
| Ballerina Language | 1.3.5                                                            |
| Twitter API        | [1.1](https://developer.twitter.com/en/docs/api-reference-index) |


## Getting Started

The Twitter connector can be instantiated using the Consumer Key (API key), Consumer Secret (API secret key), Access Token, and Access Token Secret in the Twitter configuration.

**Obtaining API Keys and Tokens to Run the Sample**

1. Create a Twitter account, if you don't have any.
2. Visit https://apps.twitter.com/app/new and sign in.
3. Provide the required information about the application.
4. Agree to the Developer Agreement and click **Create your Twitter application**.
5. After creating your Twitter application, your Consumer Key and Consumer Secret will be displayed in the "Keys and tokens" tab of your app on Twitter.
6. Click the **Keys and tokens** tab, and then enable your Twitter account to use this application by clicking the **Create my access token** button.
7. Copy the Consumer key (API key), Consumer Secret (API secret key), Access Token, and Access Token Secret from the screen.

**NOTE:** For more information, refer to the [Getting started](https://developer.twitter.com/en/docs/basics/getting-started) guide.

You can now enter the credentials in the `ballerina.conf` file as follows:
```bash
CONSUMER_KEY="<Your Consumer Key>"
CONSUMER_SECRET="<Your Consumer Secret>"
ACCESS_TOKEN="<Your Access Token>"
ACCESS_TOKEN_SECRET="<Your Access Token Secret>"
```

## API Guide

First, import the `sandalukalpanee/twitter` module into the Ballerina project.

```ballerina
import sandalukalpanee/twitter;
```

Now, create the Twitter client using the credentials entered into `ballerina.conf` file.

```ballerina
twitter:Configuration twitterConfig = {
    consumerKey: config:getAsString("CONSUMER_KEY"),
    consumerSecret: config:getAsString("CONSUMER_SECRET"),
    accessToken: config:getAsString("ACCESS_TOKEN"),
    accessTokenSecret: config:getAsString("ACCESS_TOKEN_SECRET")
};
twitter:Client twitterClient = new(twitterConfig);
```

The `tweet` API updates the current status as a Tweet. If the status was updated successfully, the response from the `tweet` API is a `twitter:Status` object with the ID of the status, created time of status, etc. If the status update was unsuccessful, the response is a `error`.

```ballerina
string status = "This is a sample tweet!";
var result = twitterClient->tweet(status);
if (result is twitter:Status) {
    // If successful, print the tweet ID and text.
    io:println("Tweet ID: ", result.id);
    io:println("Tweet: ", result.text);
} else {
    // If unsuccessful, print the error returned.
    io:println("Error: ", result);
}
```

## Examples

```ballerina
import ballerina/io;
import sandalukalpanee/twitter;

twitter:Configuration twitterConfig = {
    consumerKey: config:getAsString("CONSUMER_KEY"),
    consumerSecret: config:getAsString("CONSUMER_SECRET"),
    accessToken: config:getAsString("ACCESS_TOKEN"),
    accessTokenSecret: config:getAsString("ACCESS_TOKEN_SECRET")
};
twitter:Client twitterClient = new(twitterConfig);

public function main() {
    string status = "This is a sample tweet!";
    var result = twitterClient->tweet(status);
    if (result is twitter:Status) {
        // If successful, print the tweet ID and text.
        io:println("Tweet ID: ", result.id);
        io:println("Tweet: ", result.text);
    } else {
        // If unsuccessful, print the error returned.
        io:println("Error: ", result);
    }
}
```
