class WeatherUtils {
  String getWeather(String weather) {
    switch (weather) {
      case 'Clear':
        //晴れ
        return '晴れ';
      case 'Clouds':
        //曇り
        return '曇り';
      case 'Rain':
        //雨
        return '雨';
      case 'Snow':
        //雪
        return '雪';
      case 'Atmosphere':
        //霧
        return '霧';
      case 'Drizzle':
        //霧雨
        return '霧雨';
      case 'Thunderstorm':
        //雷雨
        return '雷雨';
      default:
        return 'その他';
    }
  }

  //TODO あとで使用予定
  String getWeatherDetailImage(String weather) {
    switch (weather) {
      //Clear（晴れ）:clear sky（晴天）
      case 'clear sky':
        return '';

      //Clouds（雲）:few clouds（雲少なめ）
      case 'few clouds':
        return '';
      //Clouds（雲）:scattered clouds（雲散在）
      case 'scattered clouds':
        return '';
      //Clouds（雲）broken clouds（雲が切れ間）
      case 'broken clouds':
        return '';
      //Clouds（雲）:overcast clouds（厚い雲）
      case 'overcast clouds':
        return '';

      //Rain（雨）:light rain（小雨）
      case 'light rain':
        return '';
      //Rain（雨）moderate rain（適度な雨）
      case 'moderate rain':
        return '';
      //Rain（雨）:heavy intensity rain（激しい雨）
      case 'heavy intensity rain':
        return '';
      //Rain（雨）:very heavy rain（非常に激しい雨）
      case 'very heavy rain':
        return '';

      // Snow（雪）:light snow（小雪）
      case 'light snow':
        return '';
      // Snow（雪）:Snow（雪）
      case 'Snow':
        return '';
      // Snow（雪）:Heavy snow（大雪）
      case 'Heavy snow':
        return '';
      // Snow（雪）:Sleet（みぞれ）
      case 'Sleet':
        return '';

      //Atmosphere（大気）:mist（霧）
      case 'mist':
        return '';
      //Atmosphere（大気）:Smoke（煙）
      case 'Smoke':
        return '';
      //Atmosphere（大気）:Haze（靄）
      case 'Haze':
        return '';
      //Atmosphere（大気）:sand/ dust whirls（砂塵旋風）
      case 'sand/ dust whirls':
        return '';
      //Atmosphere（大気）:fog（濃霧）
      case 'fog':
        return '';

      //Drizzle（霧雨）:light intensity drizzle（弱い霧雨）
      case 'flight intensity drizzle':
        return '';
      //Drizzle（霧雨）:drizzle（霧雨）
      case 'drizzle':
        return '';
      //Drizzle（霧雨）:heavy intensity drizzle（激しい霧雨）
      case 'heavy intensity drizzle':
        return '';

      //Thunderstorm（雷雨）:thunderstorm with light rain（雷雨と小雨）
      case 'thunderstorm with light rain':
        return '';
      //Thunderstorm（雷雨）:thunderstorm with rain（雷雨）
      case 'thunderstorm with rain':
        return '';
      //Thunderstorm（雷雨）:thunderstorm with heavy rain（雷雨と激しい雨）
      case 'thunderstorm with heavy rain':
        return '';
      //Thunderstorm（雷雨）:severe thunderstorm（激しい雷雨）
      case 'severe thunderstorm':
        return '';

      default:
        return '';
    }
  }
}
