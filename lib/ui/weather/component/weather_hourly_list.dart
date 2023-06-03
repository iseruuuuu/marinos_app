import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:marinos_app/ui/weather/weather_provider.dart';
import '../../../model/weather/weather_hourly.dart';
import '../../../utils/weather_util.dart';

class WeatherHourlyList extends ConsumerWidget {
  const WeatherHourlyList({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherProvider = ref.watch(hourlyWeatherProvider);
    return Flexible(
      child: weatherProvider.when(
        data: (weatherList) {
          return ListView.builder(
            itemCount: weatherList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              final weather = weatherList[index];
              final date =
                  DateTime.fromMillisecondsSinceEpoch(weather.timestamp * 1000);
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
                        'http://openweathermap.org/img/wn/${weatherList[index].iconId}.png',
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
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Text('Error occurred'),
      ),
    );
  }
}
