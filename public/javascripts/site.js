$(function() {
  _.each($('.thirds'), function(outer) {
    $(outer).children().css('height', $(outer).height());
  });

  loadTweets();
});

$('.when-link').live('click', highlightWhen);
$('.join-link').live('click', highlightJoin);

function highlightWhen (e) {
  e.preventDefault();
  $('#when').effect('highlight', {'color': '#91dc47'}, 3000);
};

function highlightJoin (e) {
  e.preventDefault();
  $('#join').effect('highlight', {'color': '#91dc47'}, 3000);
};

function autoLinkUrl(text) {
  var urlRegex = /(https?\:\/\/[^"\s\<\>]*[^.,;'">\:\s\<\>\)\]\!])/g;
  return text.replace(urlRegex, "<a href='$1'>$1</a>");
};

function autoLinkUser(text) {
  var urlRegex = /@(\w+)/g;
  return text.replace(urlRegex, "<a href='http://twitter.com/$1'>@$1</a>");
};

function autoLinkHashtag(text) {
  var urlRegex = /#(\w+)/g;
  return text.replace(urlRegex, "<a href='https://twitter.com/search/%23$1'>#$1</a>");
};

function autoLinkTweet(text){
  text = autoLinkUrl(text);
  text = autoLinkUser(text);
  return autoLinkHashtag(text);
};

function loadTweets(){
  var $tweets    = $('#tweets');
  var template   = $('#tweetTemplate').html();
  var tweets_url = "http://api.twitter.com/1/statuses/user_timeline.json";
  var opts = {
    screen_name     : "columbusclojure",
    trim_user       : "1",
    include_rts     : "1",
    exclude_replies : "0",
    count           : "6"
  };

  $.ajax({
    url: tweets_url,
    data: opts,
    dataType: 'jsonp',
    success: function(data) {
      _.each(data, function(tweet) {
        if (!_.isUndefined(tweet)) {
          var text  = autoLinkTweet(tweet.text);
          var time  = Date.create(tweet.created_at).relative();
          var html  = _.template(template, {tweet: text, time: time});
          var div   = $('<div>').html(html);
          div.addClass('tweet');
          div.addClass('half');
          $tweets.append(div);
        }
      });
    }
  });
};
