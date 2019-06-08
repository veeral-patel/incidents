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
//= require_tree .

$(document).ready(function() {
  $("label").addClass("label");
  $("textarea").addClass("textarea");
  $("input[type=text]").addClass("input");
  $("input[type=password]").addClass("input");
  $("input[type=email]").addClass("input");
  $("button").addClass("button is-link");

  // fade out notices
  $(".message.is-success" ).fadeOut(2000);


  Mousetrap.bind('shift+t', function() {
      window.location.replace("/tickets/new")
  });

  Mousetrap.bind('shift+i', function() {
      window.location.replace("/incidents/new")
  });
});


