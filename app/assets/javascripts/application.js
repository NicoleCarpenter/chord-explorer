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

var searchString = ""

$(document).ready(function() {

  $('#submit-tag').on('click', function() {
    // When clicking on .js-close, find the parent .js-page and add .is-closed to its classlist.
    $('.js-page').toggleClass('is-closed');
  })

  $('.js-closeToggle').on('click', function() {
    // When clicking on .js-close, find the parent .js-page and add .is-closed to its classlist.
    $('.js-page').toggleClass('is-closed');
  })

  //clicks on left hand side
  $(".btn-default").click(function(event){
    $(".navbar-fixed-bottom").css("display", "block");

    $(this).clone().appendTo(".navbar-fixed-bottom").css("margin", "+=10px");

    var chordName = $(this).attr("id");
    searchString = searchString + ", " + chordName;
  });

  //clicks in well
  $("body").on("click", ".navbar .btn-default", function(event){
    var chordName = $(this).attr("id");
    $("#"+chordName).attr("class","btn btn-default "+chordName);
    searchString = searchString.replace(", " + chordName, "");
    $(this).remove();
    return searchString
  });

  //clicks on search in well, sends chords to form and seargit ches
  $("body").on("click","#submit-tag",function(event){
    $("#search").val(searchString);
    $("#hiddensearch").submit(function(){
      event.preventDefault();
      console.log("We're going to make an AJAX request")
      console.log($(this).serialize());
      $(this).serialize();
    })
  })

  $(function(){
    $("#add-to-well").submit(function() {return false});
  });

  // $("#sidebar-submit").on("click", function (event){
  //replace the next three lines with the above to revert to the old way
    $("#add-to-well").on("keyup", function(event){
      event.preventDefault();
      if (event.keyCode == 13) {
        var chord_string = ($("#sidebar-value").val());
        chord_string = chord_string.split(",");
        for (var i = 0; i < chord_string.length; i++){
          chord_string[i] = chord_string[i].trim();
      }
    };
    //iterate over chord_string
    //use chord_string as id and call click on the element
    if (chord_string != undefined){
      for (var i=0; i<chord_string.length; i++){
        if (searchString.includes(chord_string[i].replace("#","sharp").replace("/","slash")) == false){
          $("#"+chord_string[i].replace("#","sharp").replace("/","slash")).click();
        }
      }
    }
  })
});
