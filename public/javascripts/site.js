$(function() {
  $('.when-link').on('click', highlightWhen);
  $('.join-link').on('click', highlightJoin);

  resizeThirds();
  App.Tweets.loadTweets();
});

function resizeThirds() {
  _.each($('.thirds'), function(outer) {
    $(outer).children().css('height', $(outer).height());
  });
}

var App = {};

App.Colors = {
  green: '#91dc47'
};

function highlight (selector) {
  $(selector).effect('highlight', {'color': App.Colors.green}, 3000);
}

function highlightWhen (e) {
  e.preventDefault();
  highlight('#when');
}

function highlightJoin (e) {
  e.preventDefault();
  highlight('#join');
}

App.Tweets = {
  linkUrls: function(text) {
    var urlRegex = /(https?\:\/\/[^"\s\>]*[^.,;'">\:\s\>\)\]\!])/g;
    return text.replace(urlRegex, "<a href='$1'>$1</a>");
  },

  linkMentions: function(text) {
    var urlRegex = /@(\w+)/g;
    return text.replace(urlRegex, "<a href='http://twitter.com/$1'>@$1</a>");
  },

  linkHashtags: function(text) {
    var urlRegex = /#(\w+)/g;
    return text.replace(urlRegex, "<a href='https://twitter.com/search/%23$1'>#$1</a>");
  },

  addLinksToTweets: function(text) {
    text = this.linkUrls(text);
    text = this.linkMentions(text);
    return this.linkHashtags(text);
  },

  drawTweet: function(tweet) {
    if (!_.isUndefined(tweet)) {
      var $tweets  = $('#tweets');
      var template = $('#tweetTemplate').html();
      var text     = this.addLinksToTweets(tweet.text);
      var time     = Date.create(tweet.created_at).relative();
      var html     = _.template(template, {tweet: text, time: time});
      var div      = $('<div>').html(html).addClass('tweet half');
      $tweets.append(div);
    }
  },

  loadTweets: function() {
    var self = this;
    $.get('/tweets', function(tweets) {
      _.each(tweets, function(tweet) {
        self.drawTweet(tweet);
      });
    });
  }
};
