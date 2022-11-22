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

import '../stylesheets/header.css'
import '../stylesheets/footer.css'
import '../stylesheets/simple_calendar.css'
import '../stylesheets/fontawesome.css'
import '../stylesheets/card_box.css'
import '../stylesheets/chat.css'
import '../stylesheets/client_record.css'
import '../stylesheets/btn.css'
import '../stylesheets/notification.css'

Rails.start()
Turbolinks.start()
ActiveStorage.start()

// 他のページから遷移した際、うまくいかなかったため、turbolinks:loadを加えた
$(document).on('turbolinks:load', function () {
  $('#basic_infomation').on('click', function() {
    $('#basic_infomation_content').removeClass('d-none');
    $('#therapist_infomation_content').addClass('d-none');
  })
  $('#therapist_infomation').on('click', function() {
    $('#therapist_infomation_content').removeClass('d-none');
    $('#basic_infomation_content').addClass('d-none');
  })
})