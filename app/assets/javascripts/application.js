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

  //Resets the page. On click, finds the parent .js-page and adds .is-closed to its class list.
  $('#submit-tag').on('click', function() {
    $('.profile').empty();
    $('.chords').empty();
    $('.js-page').addClass('is-closed');
  })

  $('.js-closeToggle').on('click', function() {
    $('.js-page').addClass('is-closed');
  })

 //Profile button in sidebar. When clicked, empties whatever current partial is displayed.
  $("#profile").on("click", function(event){
    event.preventDefault();
    $('.profile').addClass("profile-is-active");
    $('#results').empty();
    $('.chords').empty();
    $('.js-page').addClass('is-closed');
  });

  //Sign Up button in sidebar. Renders registration form via AJAX request.
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
  //Submit button within the registration form. Creates a new user. /users/create.js.erb then renders the profile page.
  $("body").on("submit", "#new_user",function(event){
    event.preventDefault()
    data = $(this).serialize();
    var request = $.ajax({
      url: "/users",
      type: "POST",
      data: data
    })
  })

  //Login button in sidebar. Renders login form via AJAX request.
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
  //Submit button within the login form. Creates a new session. /sessions/create.js.erb then renders the profile page.
  $("body").on("submit", "#new_session",function(event){
    event.preventDefault();
    data = $(this).serialize();
    var request = $.ajax({
      url: "/login",
      type: "POST",
      data: data
    })
  })

  //All Chords button in sidebar. Renders the all chords page via AJAX request.
  $("#sidebar-wrapper").on("click","#chords",function(event){
    event.preventDefault();
    $('.profile').removeClass("profile-is-active");
    $('.js-page').addClass('is-closed');
    var request = $.ajax({
      url: "/chords",
      type: "GET"
    })
    request.done(function(response){
      $(".profile").html(response);
    })
  })

  //Chord buttons in sidebar trays.
  $(".unpressed").click(function(event){
    //Displays the well at the bottom of the page.
    $(".navbar-fixed-bottom").css("display", "block");
    //When chord button is clicked in sidebar, this checks to see if it already exists in the bottom well - if it doesn't, it adds it.
    if ($("#added_chords #" + $(this).attr("id")).length == false
  ){$(this).clone().removeClass("focus").addClass("unpressed").appendTo("#added_chords").css("margin", "+=10px");
      //Adds the chord id to the searchString.
      var chordName = $(this).attr("id");
      searchString = searchString + ", " + chordName;}
    //If chord button already exists in the bottom well, it adds the "pressed" class, so the button won't toggle between pressed/unpressed (default behavior).
    else{$(this).css("class","btn btn-default "+chordName+" active")}
    $(this).addClass("pressed").removeClass("unpressed");
  });

  //When chord buttons are clicked in the bottom well, it removes them from the searchString and resets the button in the sidebar.
  $("body").on("click", ".navbar .btn-default", function(event){
    var chordName = $(this).attr("id");
    $("#"+chordName).attr("class","btn btn-default "+chordName);
    searchString = searchString.replace(", " + chordName, "");
    $(this).remove();
    return searchString;
  });

  //Clear These Chords button in bottom well. Resets the searchString and simulates a click on each button in the well, resetting them via the functionality above.
  $("body").on("click","#clear-well-button",function(event){
    $("#added_chords .btn").click();
    searchString = ""
  })

  //Find Tabs button in bottom well. Sends the searchString data to the hidden form and submits it.
  $("body").on("click","#submit-tag",function(event){
    $('.profile').removeClass("profile-is-active");
    $("#search").val(searchString);
    $("#hiddensearch").submit(function(){
      event.preventDefault();
      $(this).serialize();
    })
  })

  //Save These Chords button in bottom well. Sends the searchString data to the save chords form and submits it.
  $("body").on("click","#save-chords-button",function(event){
    $("#save_chords").val(searchString);
    $("#save-chords-form").submit(function(){
      event.preventDefault();
      $(this).serialize();
    })
  })

  //Add Saved Chords button in sidebar. /user_saved_chords/index.js.erb will add the user's previously saved chords to the bottom well by simulating click events in the sidebar.
  $("body").on("click","#add-saved-chords-button",function(event){
    $.get("/user_saved_chords")
  })

  //Remove From Repertoire button in profile. Destroys the user_saved_chord entry for that user.
  $("body").on("click",".remove-saved-chords-button",function(event){
    var request = $.ajax({
      url: "/user_saved_chords/" + $(this).attr('id'),
      type: "DELETE"
    })
    request.done;
  });

  //Prevents page refresh when the user hits Enter. Needed for Enter key re-map below.
  $(function(){
    $("#add-to-well").submit(function() {return false});
  });

    //Re-maps Enter key to submit chords in the text box. Splits the string into an array of chord name/ids, then trims the whitespace around each.
    $("#add-to-well").on("keyup", function(event){
      event.preventDefault();
      if (event.keyCode == 13) {
        var chord_string = ($("#sidebar-value").val());
        chord_string = chord_string.split(",");
        for (var i = 0; i < chord_string.length; i++){
          chord_string[i] = chord_string[i].trim();
      }
    };
    //Iterates over the chord_string array, replaces the #s and /s with sharps and slashes (which was conflicting with jQuery), and simulates click events for each chord so that they are added to the bottom well.
    if (chord_string != undefined){
      for (var i=0; i<chord_string.length; i++){
        if (searchString.includes(chord_string[i].replace("#","sharp").replace("/","slash")) == false){
          $("#"+chord_string[i].replace("#","sharp").replace("/","slash")).click();
        }
      }
    }
  })

  //Tabs in the All Chords page. This keeps the clicked tab active.
  $(function() {
    $("body").on("click", ".nav-tabs a", function (e) {
      e.preventDefault();
      $(this).tab('show');
      $('.chord').chordsIO();
    });
  });
});
