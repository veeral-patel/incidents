// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require jquery
//= require jquery.atwho
//= require datatables
//= require_tree .

$(document).ready(function() {
  // fade out notices
  $(".message.is-success").fadeOut(2000);

  // escape unfocuses inputs
  $("input[type=text]").keyup(function(e) {
    if (e.keyCode === 27) $(this).blur();
  });

  // and text areas
  $("textarea").keyup(function(e) {
    if (e.keyCode === 27) $(this).blur();
  });

  // shift-i to create an incident
  Mousetrap.bind("shift+i", function() {
    window.location.replace("/incidents/new");
  });

  // shift-s to select the search box
  Mousetrap.bind("shift+s", function(event) {
    event.preventDefault();
    if ($(".search_input").val()) {
      $(".search_input").val("");
    }
    $(".search_input").focus();
  });

  // submit forms with Cmd-Enter in textareas
  $(document).on("keydown", "body", function(e) {
    if (!(e.keyCode == 13 && e.metaKey)) return;

    var $target = $(e.target);
    if ($target.is("textarea")) {
      $target.closest("form").submit();
    }
  });
});
