import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../model/weather/weather_hourly.dart';
import '../../../utils/weather_util.dart';

class WeatherHourlyList extends StatelessWidget {
  const WeatherHourlyList({
    super.key,
    required Future<List<WeatherHourly>>? futureWeather,
  }) : _futureWeather = futureWeather;

  final Future<List<WeatherHourly>>? _futureWeather;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: FutureBuilder<List<WeatherHourly>>(
        future: _futureWeather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                'Error: ${snapshot.error}',
              ),
            );
          } else {
            final weatherList = snapshot.data!;
            return ListView.builder(
              itemCount: weatherList.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final weather = weatherList[index];
                final date = DateTime.fromMillisecondsSinceEpoch(
                    weather.timestamp * 1000);
                final formattedDate = DateFormat.Hm().format(date);
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
                          WeatherUtils().getWeatherImage(
                            weatherList[index].mainWeather,
                          ),
                        ),
                      ),
                      Text(
                        '${weatherList[index].temperature}°C',
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Text(
                        '${weatherList[index].rainVolume}%',
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
