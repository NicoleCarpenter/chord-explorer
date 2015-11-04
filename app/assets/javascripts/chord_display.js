$(function() {
  $('.chord').chordsIO();
});

$(document).on('page:fetch', function() {
  $("#spinner").spin({
    lines: 13, // The number of lines to draw
    length: 8, // The length of each line
    width: 9, // The line thickness
    radius: 30, // The radius of the inner circle
    color: '#000000', // #rgb or #rrggbb
    speed: 2, // Rounds per second
    trail: 50, // Afterglow percentage
    shadow: true // Whether to render a shadow
  });
});
$(document).on('page:change', function() {
  $("#spinner").spin(false);
});