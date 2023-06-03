import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:marinos_app/constants/weather_constants.dart';
import '../../api/weather_hourly_api.dart';
import '../../api/weather_week_api.dart';
import '../../model/weather/weather_hourly.dart';
import 'component/weather_day_widget.dart';
import 'component/weather_hourly_list.dart';
import 'component/weather_weekly_list.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  WeatherScreenState createState() => WeatherScreenState();
}

class WeatherScreenState extends State<WeatherScreen> {
  late Map<String, dynamic> _weatherData;
  bool _isLoading = false;
  late String _error;
  final weatherService = WeatherService(
    baseUrl: 'https://api.openweathermap.org/data/2.5',
    apiKey: WeatherConstants.weatherApikey,
  );
  final WeatherHourlyService _weatherHourlyService = WeatherHourlyService();
  Future<List<WeatherHourly>>? _futureWeather;

  @override
  void initState() {
    super.initState();
    _getCityWeather();
    _futureWeather = _weatherHourlyService.fetchHourlyWeather();
  }

  Future<void> _getCityWeather() async {
    setState(() {
      _isLoading = true;
      _error = "";
    });

    try {
      final url = Uri.parse(
        'http://api.openweathermap.org/data/2.5/weather?lat=35.5068127&lon=139.6149964&appid=${WeatherConstants.weatherApikey}&units=metric',
      );
      final response = await http.get(url);
      if (response.statusCode == 200) {
        _weatherData = jsonDecode(response.body);
      } else {
        throw Exception('Failed to get weather data');
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text(
          '新横浜の天気情報',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_error != "")
              Text('Error: $_error')
            else if (_weatherData != null)
              Column(
                children: [
                  WeatherDayWidget(weatherData: _weatherData),
                  WeatherWeeklyList(weatherService: weatherService),
                  WeatherHourlyList(futureWeather: _futureWeather),
                ],
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _getCityWeather(),
      ),
    );
  }
}
