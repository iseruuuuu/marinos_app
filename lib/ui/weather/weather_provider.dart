import 'dart:convert';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marinos_app/api/weather/weather_hourly_api.dart';
import 'package:marinos_app/model/weather/weather_hourly.dart';
import '../../api/weather/weather_week_api.dart';
import 'package:http/http.dart' as http;

import '../../constants/apikey.dart';

final weatherServiceProvider = Provider<WeatherService>(
  (ref) {
    return WeatherService(
      baseUrl: 'https://api.openweathermap.org/data/2.5',
      apiKey: WeatherConstants.weatherApikey,
    );
  },
);

final hourlyWeatherProvider = FutureProvider<List<WeatherHourly>>((ref) async {
  final hourlyService = ref.watch(hourlyWeatherServiceProvider);
  final weather = await hourlyService.fetchHourlyWeather();
  return weather;
});

final hourlyWeatherServiceProvider = Provider<WeatherHourlyService>(
  (ref) {
    return WeatherHourlyService();
  },
);

final weatherHourlyServiceProvider = Provider<WeatherHourlyService>(
  (ref) {
    return WeatherHourlyService();
  },
);

final weatherFutureProvider = FutureProvider.autoDispose<List<WeatherHourly>>(
  (ref) async {
    return ref.watch(weatherHourlyServiceProvider).fetchHourlyWeather();
  },
);

final weatherDataFutureProvider =
    FutureProvider.autoDispose<Map<String, dynamic>>(
  (ref) async {
    final url = Uri.parse(
      'http://api.openweathermap.org/data/2.5/weather?lat=35.5068127&lon=139.6149964&appid=${WeatherConstants.weatherApikey}&units=metric',
    );
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to get weather data');
    }
  },
);
