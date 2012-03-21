$(function() {
  _.each($('.thirds'), function(outer) {
    $(outer).children().css('height', $(outer).height());
  });
});

$('.when-link').live('click', highlightWhen);
$('.join-link').live('click', highlightJoin);

function highlightWhen () {
  $('#when').effect('highlight', {'color': '#91dc47'}, 3000);
}

function highlightJoin () {
  $('#join').effect('highlight', {'color': '#91dc47'}, 3000);
}
