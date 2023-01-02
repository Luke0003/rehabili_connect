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


  // 緯度経度を取得し、天気を表示する自作API
  $.ajax({
    url: gon.api_endpoint + "/api/v1/prefectures",
    dataType : 'json',
  }).done(function(prefecture){
    var clientPrefecture = prefecture.prefectures[gon.prefecture_id].prefecture_name;
    var clientPrefectureLatitude = prefecture.prefectures[gon.prefecture_id].latitude;
    var clientPrefectureLongitude = prefecture.prefectures[gon.prefecture_id].longitude;
    $('#place').text(clientPrefecture + "の天気");
    openWeatherMap(clientPrefectureLatitude, clientPrefectureLongitude);
  }).fail(function (data) {
    //通信失敗
    alert('通信に失敗しました。');
  });

  function openWeatherMap(clientPrefectureLatitude, clientPrefectureLongitude){
    $.ajax({
      url: "https://api.openweathermap.org/data/2.5/weather?lat=" + clientPrefectureLatitude + "&lon=" + clientPrefectureLongitude + "&APPID=" + gon.secret_api_key,
      dataType : 'jsonp',
    }).done(function (data){
      //通信成功
      // 最高気温
      $('#temp_max').text(Math.round(data.main.temp_max - 273.15));
      // 最低気温
      $('#temp_min').text(Math.round(data.main.temp_min - 273.15));
      // 天気
      $('#weather').text(data.weather[0].main);
      // 天気アイコン
      $('#img').attr("src","https://openweathermap.org/img/w/" + data.weather[0].icon + ".png");
      $('#img').attr("alt",data.weather[0].main);
    }).fail(function (data) {
      //通信失敗
      alert('通信に失敗しました。');
    });
  };
})