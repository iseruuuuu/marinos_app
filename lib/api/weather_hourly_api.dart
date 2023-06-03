import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:marinos_app/constants/weather_constants.dart';
import '../model/weather/weather_hourly.dart';

class WeatherHourlyService {
  final String _apiKey = WeatherConstants.weatherApikey;
  Future<List<WeatherHourly>> fetchHourlyWeather() async {
    final response = await http.get(
      Uri.parse('https://api.openweathermap.org/data/2.5/onecall?lat=35.5068127&lon=139.6149964&exclude=current,minutely,daily,alerts&appid=$_apiKey&units=metric'),
    );
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final hourlyData = data['hourly'] as List;
      return hourlyData.map((json) => WeatherHourly.fromJson(json)).toList();
    } else {
      throw Exception('Failed to fetch weather data');
    }
  }
}
