import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../api/weather/weather_week_api.dart';
import '../../../model/weather/weather.dart';

class WeatherWeeklyList extends StatelessWidget {
  const WeatherWeeklyList({
    super.key,
    required this.weatherService,
  });

  final WeatherService weatherService;

  @override
  Widget build(BuildContext context) {
    return Flexible(
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
              itemCount: weatherList.length,
              itemBuilder: (context, index) {
                final weather = weatherList[index];
                final date = DateTime.fromMillisecondsSinceEpoch(
                  weather.date * 1000,
                );
                final formattedDate = DateFormat('d(EE)', 'ja_JP').format(date);
                return Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(),
                    ),
                  ),
                  child: ListTile(
                    leading: Text(
                      formattedDate,
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    title: Row(
                      children: [
                        Image.network(
                          'http://openweathermap.org/img/wn/${weather.weather[0].icon}.png',
                        ),
                        const Spacer(),
                        Text(
                          '${weather.temperature.max.toInt()}°C',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          '${weather.temperature.min.toInt()}°C',
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                        const Spacer(),
                        Text(
                          weather.rainVolume != null
                              ? '${weather.rainVolume?.toInt()}%'
                              : '0%',
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
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
