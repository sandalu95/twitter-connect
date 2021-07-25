# Define the status, AKA Tweet.
#
# + createdAt - Created time of the status
# + id - Id of the status
# + text - Text message of the status
# + source - Source app of the status
# + truncated - Whether the status is truncated or not
# + favorited - Whether the status is favorited or not
# + retweeted - Whether the status is retweeted or not
# + favoriteCount - Favourite count of the status
# + retweetCount - Retweet count of the status
# + lang - Language of the status
public type Status record {
    string createdAt = "";
    int id = 0;
    string text = "";
    string 'source = "";
    boolean truncated = false;
    boolean favorited = false;
    boolean retweeted = false;
    int favoriteCount = 0;
    int retweetCount = 0;
    string lang = "";
};
