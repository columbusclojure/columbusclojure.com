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
}

function highlightJoin (e) {
  e.preventDefault();
  $('#join').effect('highlight', {'color': '#91dc47'}, 3000);
}

function autoLinkTweet(text){
  var urlRegex = /(https?\:\/\/[^"\s\<\>]*[^.,;'">\:\s\<\>\)\]\!])/g;
  text = text.replace(urlRegex, "<a href='$1'>$1</a>");
  text = text.replace(/@(\w+)/gi, "<a href='http://twitter.com/$1'>@$1</a>");
  return text;
};

function loadTweets(){
  var target     = $('#tweets');
  var template   = $('#tweetTemplate').html();
  var tweetCount = 6;
  var tweet_url  = "http://api.twitter.com/1/statuses/user_timeline.json?screen_name=columbusclojure&count="+tweetCount+"&trim_user=1&exclude_replies=1";

  $.ajax({
    url: tweet_url,
    dataType: 'jsonp',
    success: function(data){
      for(var i=0; i<tweetCount; i++){
        var tweet = data[i];
        if (tweet !== undefined) {
          var text  = autoLinkTweet(tweet.text);
          var time  = Date.create(tweet.created_at).relative();
          var html  = _.template(template, {tweet: text, time: time});
          var li    = $('<li>').html(html);
          target.append(li);
        }
      }
    }
  });
};
