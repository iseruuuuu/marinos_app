import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:marinos_app/constants/weather_constants.dart';

import '../../api/weather_week_api.dart';
import '../../model/weather.dart';

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

  @override
  void initState() {
    super.initState();
    _getCityWeather();
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
        print(_weatherData);
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
          children: <Widget>[
            if (_isLoading)
              const CircularProgressIndicator()
            else if (_error != "")
              Text('Error: $_error')
            else if (_weatherData != null)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text('天気'),
                          Text(
                            '${_weatherData['weather'][0]['main']}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('詳細な天気'),
                          Text(
                            '${_weatherData['weather'][0]['description']}',
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text('現在の気温'),
                      Text(
                        ' ${_weatherData['main']['temp']}°C\n',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text('最高気温'),
                          Text(
                            '${_weatherData['main']['temp_max']}°C\n',
                            style: const TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          const Text('最低気温'),
                          Text(
                            '${_weatherData['main']['temp_min']}°C\n',
                            style: const TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      Text('湿度'),
                      Text(
                        '${_weatherData['main']['humidity']}%',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const Text('風速'),
                      Text(
                        '${_weatherData['wind']['speed']}m/s',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  Column(
                    children: [
                      const Text('気圧'),
                      Text(
                        '${_weatherData['main']['pressure']} Pa\n',
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      )
                    ],
                  ),
                  Container(
                    height: 250,
                    color: Colors.greenAccent,
                    child: Expanded(
                      child: FutureBuilder(
                        future: weatherService.getWeeklyWeather(
                            35.5068127, 139.6149964),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          } else if (snapshot.hasError) {
                            return Text('Error: ${snapshot.error}');
                          } else {
                            final weatherList = snapshot.data as List<Weather>;
                            return ListView.builder(
                              itemCount: weatherList.length,
                              itemBuilder: (context, index) {
                                final weather = weatherList[index];
                                final date =
                                    DateTime.fromMillisecondsSinceEpoch(
                                  weather.date * 1000,
                                );
                                final formattedDate =
                                    DateFormat('MM月dd日').format(date);
                                return ListTile(
                                  title: Text(formattedDate),
                                  subtitle:
                                      Text('最低温度: ${weather.temperature.max}\n'
                                          '最低温度: ${weather.temperature.min}\n'
                                          '天気: ${weather.weather[0].main}\n '
                                          //降水量がnullになる？？
                                          // '降水量: ${weather.rainVolume}',
                                          ),
                                );
                              },
                            );
                          }
                        },
                      ),
                    ),
                  ),
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
