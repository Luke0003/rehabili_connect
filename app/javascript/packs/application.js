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
import '../stylesheets/weather.css'
import '../stylesheets/today_menus.css'

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

  // チャットのテキストエリアの高さを広げる
  $("#chat_message").on('input', function() {
    if ($(this).outerHeight() > this.scrollHeight) {
      $(this).height(1)
    }
    while ($(this).outerHeight() < this.scrollHeight) {
      $(this).height($(this).height() + 1)
    }
  });

  // チャット画面を表示する際、最下部へ自動スクロール
  // ディレイをかけることで#chat_viewを全て読み込んでから処理
  $('#chat_view').delay(500).queue(function () {
    var element = document.documentElement;
    var bottom = element.scrollHeight - element.clientHeight;
    window.scroll(0, bottom);
  });
  // 自主トレメニュー設定画面のセレクトボックスとデイトフィールドのサイズを揃える
  var menuWidth = $("#client_menu_menu_id").outerWidth();
  $('#client_menu_start_date').outerWidth(menuWidth);
  $('#finish_date_finish_date').outerWidth(menuWidth);

  // ストップウォッチ
  $(function () {
    var sec = 0;
    var min = 0;
    var hour = 0;

    var timer;

    // 開始
    $('#start').click(function() {
      // 00:00:00から開始
      sec = 0;
      min = 0;
      hour = 0;
      $('#clock').html('00:00:00');
      timer = setInterval(countup, 1000);

      $(this).prop('disabled', true);
      $('#stop,#reset').prop('disabled', false);
    });
    // 停止
    $('#stop').click(function() {
      // 一時停止
      clearInterval(timer);

      $(this).prop('disabled', true);
      $('#restart').prop('disabled', false);
    });
    // 再開
    $('#restart').click(function() {
      // 一時停止から再開
      timer = setInterval(countup, 1000);

      $(this).prop('disabled', true);
      $('#stop').prop('disabled', false);
    });
    // リセット
    $('#reset').click(function() {
      // 初期状態
      sec = 0;
      min = 0;
      hour = 0;
      $('#clock').html('00:00:00');
      $('#clock').val('00:00:00');
      clearInterval(timer);

      $('#stop,#restart,#reset').prop('disabled', true);
      $('#start').prop('disabled', false);
    });

    // カウントアップ
    function countup(){
      sec += 1;

      if (sec > 59) {
        sec = 0;
        min += 1;
      }

      if (min > 59) {
        min = 0;
        hour += 1;
      }

      // 0埋め
      var sec_number = ('0' + sec).slice(-2);
      var min_number = ('0' + min).slice(-2);
      var hour_number = ('0' + hour).slice(-2);

      $('#clock').val(hour_number + ':' +  min_number + ':' + sec_number);
      $('#clock').html(hour_number + ':' +  min_number + ':' + sec_number);
    };
  });
})