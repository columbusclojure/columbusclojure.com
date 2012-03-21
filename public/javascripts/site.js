$('.when-link').live('click', highlightWhen);
$('.join-link').live('click', highlightJoin);

function highlightWhen () {
  $('#when').effect('highlight', {'color': '#91dc47'}, 3000);
}

function highlightJoin () {
  $('#join').effect('highlight', {'color': '#91dc47'}, 3000);
}
