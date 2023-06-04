import 'dart:convert';
import 'package:http/http.dart' as http;

class WeatherApi {
  final String _apiKey = "fb8f7e6a849f8948c0708c211c0efa7d";

  Future<dynamic> getCityWeather(String cityName) async {
    http.Response response = await http.get(
      Uri.https(
        'http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=$_apiKey&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      var data = response.body;
      return jsonDecode(data);
    } else {
      print(response.statusCode);
      throw 'Failed to get weather data';
    }
  }
}
