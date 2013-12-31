$(function() {
  $('.when-link').on('click', App.Highlighter.highlightWhen);
  $('.join-link').on('click', App.Highlighter.highlightJoin);

  resizeThirds();
  App.Tweets.loadTweets();
});

function resizeThirds() {
  _.each($('.thirds'), function(outer) {
    $(outer).children().css('height', $(outer).height());
  });
}
