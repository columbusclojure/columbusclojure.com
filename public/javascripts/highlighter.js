App.Highlighter = {
  init: function() {
    _.bindAll(this, 'highlightWhen', 'highlightJoin');
  },

  highlight: function(selector) {
    $(selector).effect('highlight', {'color': App.Colors.green}, 3000);
  },

  highlightWhen: function(e) {
    e.preventDefault();
    this.highlight('#when');
  },

  highlightJoin: function(e) {
    e.preventDefault();
    this.highlight('#join');
  }
};

App.Highlighter.init();
