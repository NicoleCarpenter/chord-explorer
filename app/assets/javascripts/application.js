// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require spin
//= require jquery.spin
//= require raphael-min
//= require chords.io
//= require highlight.min
//= require bootstrap.min
//= require turbolinks
//= require_tree .
//= require bootstrap.min

$(document).ready(function() {

  $('#submit-tag').on('click', function() {
    // When clicking on .js-close, find the parent .js-page and add .is-closed to its classlist.
    $('.js-page').toggleClass('is-closed');
  })

  $('.js-closeToggle').on('click', function() {
    // When clicking on .js-close, find the parent .js-page and add .is-closed to its classlist.
    $('.js-page').toggleClass('is-closed');
  })

  $(".btn-default").click(function(event){
    $(".navbar-fixed-bottom").css("display", "block");

    $(this).clone().appendTo(".navbar").css("margin", "+=10px");;

    var chordName = $(this).attr("id");

    $("#search").val(function(i, val){
      return val + ", " + chordName
    });



  });
});
