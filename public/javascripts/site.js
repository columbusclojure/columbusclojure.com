$(function() {
  _.each($('.thirds'), function(outer) {
    $(outer).children().css('height', $(outer).height());
  });

  $('.when-link').on('click', highlightWhen);
  $('.join-link').on('click', highlightJoin);
});

var green = '#91dc47';

function highlightId (id, e) {
  $('#'+id).effect('highlight', {'color': green}, 3000);
};

function highlightWhen (e) {
  e.preventDefault();
  highlightId('when');
};

function highlightJoin (e) {
  e.preventDefault();
  highlightId('join');
};
