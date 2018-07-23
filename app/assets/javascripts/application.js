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
//= require dropzone.js
//= require moment
//= require jquery3
//= require bootstrap-datetimepicker
//= require popper
//= require bootstrap-sprockets
$(document).ready(function(){
  $('.selectpicker').selectpicker();
  $(".input-block-level").bind("keyup", function() {

    $(".input-block-level").addClass("loading"); // show the spinner
    // var form = $("#live-search-form"); // grab the form wrapping the search bar.

    var url = "https://www.googleapis.com/books/v1/volumes?" // live_search action.
    // alert(url)
    var formData ={}; // grab the data in the form
    formData['q']=$(".input-block-level").val()
    console.log(formData)
    $.get(url, formData, function(data){ // perform an AJAX get
      $(".input-block-level").removeClass("loading"); // hide the spinner
      $("#post_book_self_link").empty();
      $.each(data['items'], function( index, value ) {
     // $('#live-search-form').append($('<a href="#">'+value['volumeInfo']['title']);
        if (typeof value['volumeInfo']['industryIdentifiers'] != 'undefined'){
          $('#post_book_self_link').append($('<option value="'+ value['selfLink']+'" data-subtext="'+value['volumeInfo']['industryIdentifiers'][0]['type']+': '+value['volumeInfo']['industryIdentifiers'][0]['identifier']+'">'+value['volumeInfo']['title']+'</option>'));
          console.log( index + ": " + value['volumeInfo']['title'] );
        }
       });
     }).done(function(){
           $('.selectpicker').selectpicker('refresh');
    });

  });
})
