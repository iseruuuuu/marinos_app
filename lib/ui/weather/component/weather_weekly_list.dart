import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../api/weather_week_api.dart';
import '../../../model/weather/weather.dart';
import '../../../utils/weather_util.dart';

class WeatherWeeklyList extends StatelessWidget {
  const WeatherWeeklyList({
    super.key,
    required this.weatherService,
  });

  final WeatherService weatherService;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: FutureBuilder(
        future: weatherService.getWeeklyWeather(35.5068127, 139.6149964),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            final weatherList = snapshot.data as List<Weather>;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: weatherList.length,
              itemBuilder: (context, index) {
                final weather = weatherList[index];
                final date = DateTime.fromMillisecondsSinceEpoch(
                  weather.date * 1000,
                );
                final formattedDate = DateFormat('MM/dd').format(date);
                return Container(
                  width: 70,
                  height: 70,
                  decoration: const BoxDecoration(
                    border: Border(
                      left: BorderSide(
                        color: Colors.black,
                        width: 3,
                      ),
                      top: BorderSide(
                        color: Colors.black,
                        width: 3,
                      ),
                      bottom: BorderSide(
                        color: Colors.black,
                        width: 3,
                      ),
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        formattedDate,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        width: 40,
                        height: 40,
                        child: Image.network(
                          'http://openweathermap.org/img/wn/${weather.weather[0].icon}.png',
                        ),
                      ),
                      Text(
                        '${weather.temperature.max}°C',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                      Text(
                        '${weather.temperature.min}°C',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                      Text(
                        ' ${weather.rainVolume ?? '0'}%',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
