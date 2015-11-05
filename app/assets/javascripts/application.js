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
    $('.profile').empty();
    $('.chords').empty();
    $('.js-page').addClass('is-closed');
  })

  $('.js-closeToggle').on('click', function() {
    // When clicking on .js-close, find the parent .js-page and add .is-closed to its classlist.
    $('.js-page').addClass('is-closed');
  })

  // $("#register").on("click", function(event){
  //   event.preventDefault();
  //   $('.profile').empty();
  //   $('#results').empty();
  //   $('.js-page').addClass('is-closed');
  // });

 //when you click the "profile" button in the sidebar, it resets some variables and adds the profile-is-active class, which is used in the "save these chords" ajax
  $("#profile").on("click", function(event){
    event.preventDefault();
    $('.profile').addClass("profile-is-active");
    $('#results').empty();
    $('.chords').empty();
    $('.js-page').addClass('is-closed');
  });

//when you click "sign up", ajax renders the form, then handles submit
  $("#register").on("click",function(event){
    $('.profile').removeClass("profile-is-active");
    event.preventDefault();
    $('.js-page').addClass('is-closed');
    var request = $.ajax({
      url: "/users/new",
      type: "GET",
      dataType: "HTML"
    })
    request.done(function(response){
      $(".profile").html(response);
    })
  })
  $("body").on("submit", "#new_user",function(event){
    event.preventDefault()
    data = $(this).serialize();
    var request = $.ajax({
      url: "/users",
      type: "POST",
      data: data
    })
  })

  //when you click "login", ajax renders the form, then handles submit
  $("#login").on("click",function(event){
    $('.profile').removeClass("profile-is-active");
    event.preventDefault();
    $('.js-page').addClass('is-closed');
    var request = $.ajax({
      url: "/login",
      type: "GET",
      dataType: "HTML"
    })
    request.done(function(response){
      $(".profile").html(response);
    })
  })
  $("body").on("submit", "#new_session",function(event){
    event.preventDefault()
    data = $(this).serialize();
    var request = $.ajax({
      url: "/login",
      type: "POST",
      data: data
    })
  })

  //clicks on left hand side clone and render buttons in the well
  $(".unpressed").click(function(event){
    $(".navbar-fixed-bottom").css("display", "block");
    if ($("#added_chords #" + $(this).attr("id")).length == false
  ){$(this).clone().removeClass("focus").addClass("unpressed").appendTo("#added_chords").css("margin", "+=10px");
      var chordName = $(this).attr("id");
      searchString = searchString + ", " + chordName;}
    else{$(this).css("class","btn btn-default "+chordName+" active")}
    $(this).addClass("pressed").removeClass("unpressed");
  });

  //clicks in well reset buttons in sidebar
  $("body").on("click", ".navbar .btn-default", function(event){
    var chordName = $(this).attr("id");
    $("#"+chordName).attr("class","btn btn-default "+chordName);
    searchString = searchString.replace(", " + chordName, "");
    $(this).remove();
    return searchString
  });

  //clicks on search, "Find Tabs" in well, sends chords to form and searches it
  $("body").on("click","#submit-tag",function(event){
    $('.profile').removeClass("profile-is-active");
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
    var request = $.ajax({
      url: "/user_saved_chords/" + $(this).attr('id'),
      type: "DELETE"
    })
    request.done;
  });

  //when you click the "all chords" link on the main sidebar, it removes the profile-is-active class. this is needed for the "save these chords" ajax to function.
  $("body").on("click","#chords",function(event){
    $('.profile').removeClass("profile-is-active");
  })

  //this prevents page refresh on Enter. needed for the keyup event below
  $(function(){
    $("#add-to-well").submit(function() {return false});
  });

  //makes enter submit the chords written in the left sidebar
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
