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