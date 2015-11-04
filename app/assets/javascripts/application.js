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
//= require jquery.bootpag.min
//= require bootstrap.min
//= require turbolinks
//= require_tree .

var searchString = ""

$(document).ready(function() {

  $('#submit-tag').on('click', function() {
    // When clicking on .js-close, find the parent .js-page and add .is-closed to its classlist.
    $('.profile').empty();
    $('.chords').empty();
    $('.js-page').addClass('is-closed');
  })

  $('.js-closeToggle').on('click', function() {
    // When clicking on .js-close, find the parent .js-page and add .is-closed to its classlist.
    $('.js-page').addClass('is-closed');
  })

  // $("#all_chords").on("click", function(event){
  //   event.preventDefault();
  //   $('.js-page').toggleClass('is-closed');
  // });

  $("#profile").on("click", function(event){
    event.preventDefault();
    $('#results').empty();
    $('.js-page').addClass('is-closed');
  });

  //clicks on left hand side
  $(".unpressed").click(function(event){
    $(".navbar-fixed-bottom").css("display", "block");
    if ($("#added_chords #" + $(this).attr("id")).length == false
  ){$(this).clone().removeClass("focus").addClass("unpressed").appendTo("#added_chords").css("margin", "+=10px");
      var chordName = $(this).attr("id");
      searchString = searchString + ", " + chordName;}
    else{$(this).css("class","btn btn-default "+chordName+" active")}
    $(this).addClass("pressed").removeClass("unpressed");
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
      $(this).serialize();
    })
  })

  //"save these chords" button will save chords to user's user_saved_chords
  $("body").on("click","#save-chords-button",function(event){
    $("#save_chords").val(searchString);
    $("#save-chords-form").submit(function(){
      event.preventDefault();
      $(this).serialize();
    })
  })

  //"clear these chords" button will clear the current well and reset searchString
  $("body").on("click","#clear-well-button",function(event){
    $("#added_chords .btn").click();
    searchString = ""
  })

  //"add saved chords" button will add all saved chords to the current well
  $("body").on("click","#add-saved-chords-button",function(event){
    $.get("/user_saved_chords")
  })





  //"forget this chord" button will destroy the saved chord for the user
  $("body").on("click",".remove-saved-chords-button",function(event){
    console.log($(this).attr('id'));
    var request = $.ajax({
      url: "/user_saved_chords/" + $(this).attr('id'),
      type: "DELETE"
    })
    request.done;
  });





  //this prevents page refresh on Enter. needed for the keyup event below
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
