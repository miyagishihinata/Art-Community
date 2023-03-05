// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"

import "jquery";
import "popper.js";
import "bootstrap";
import "../stylesheets/application"
import '@fortawesome/fontawesome-free/js/all'

$(document).on('turbolinks:load', function() {
  $(".reply .btn").on('click', function(e) {
   $(this).parent().find('.items').slideToggle(500, alertFunc());
  });

  function alertFunc(){
    if ($(this).css('display') == 'block') {
      $('#btn-txt').text("💬コメント返信");
    }else {
      $('#btn-txt').text("💬コメント返信");
    }
  };
});

Rails.start()
Turbolinks.start()
ActiveStorage.start()
