import 'package:http/http.dart' as http;
import 'dart:convert';

import '../model/weather/weather.dart';

class WeatherService {
  final String baseUrl;
  final String apiKey;

  WeatherService({
    required this.baseUrl,
    required this.apiKey,
  });

  Future<List<Weather>> getWeeklyWeather(double lat, double lon) async {
    final response = await http.get(
      Uri.parse(
        '$baseUrl/onecall?lat=$lat&lon=$lon&exclude=current,minutely,hourly&appid=$apiKey&units=metric',
      ),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final dailyWeather = jsonResponse['daily'] as List;

      return dailyWeather.map((json) => Weather.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load weather data');
    }
  }
}
