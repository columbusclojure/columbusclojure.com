$(function() {
  _.each($('.thirds'), function(outer) {
    $(outer).children().css('height', $(outer).height());
  });

  $('.when-link').on('click', highlightWhen);
  $('.join-link').on('click', highlightJoin);

  loadTweets();
});

var green = '#91dc47';

function highlightId (id, e) {
  $('#'+id).effect('highlight', {'color': green}, 3000);
}

function highlightWhen (e) {
  e.preventDefault();
  highlightId('when');
}

function highlightJoin (e) {
  e.preventDefault();
  highlightId('join');
}

function linkUrls(text) {
  var urlRegex = /(https?\:\/\/[^"\s\>]*[^.,;'">\:\s\>\)\]\!])/g;
  return text.replace(urlRegex, "<a href='$1'>$1</a>");
}

function linkMentions(text) {
  var urlRegex = /@(\w+)/g;
  return text.replace(urlRegex, "<a href='http://twitter.com/$1'>@$1</a>");
}

function linkHashtags(text) {
  var urlRegex = /#(\w+)/g;
  return text.replace(urlRegex, "<a href='https://twitter.com/search/%23$1'>#$1</a>");
}

function addLinksToTweets(text){
  text = linkUrls(text);
  text = linkMentions(text);
  return linkHashtags(text);
}

function drawTweet(tweet) {
  var $tweets    = $('#tweets');
  var template   = $('#tweetTemplate').html();

  if (!_.isUndefined(tweet)) {
    var text  = addLinksToTweets(tweet.text);
    var time  = Date.create(tweet.created_at).relative();
    var html  = _.template(template, {tweet: text, time: time});
    var div   = $('<div>').html(html);
    div.addClass('tweet');
    div.addClass('half');
    $tweets.append(div);
  }
}

function loadTweets() {
  $.get('/tweets', function(tweets) {
    _(6).times(function(n) {
      drawTweet(tweets[n]);
    });
  });
}
