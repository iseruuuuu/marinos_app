import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marinos_app/ui/weather/weather_provider.dart';
import 'component/weather_day_widget.dart';
import 'component/weather_hourly_list.dart';
import 'component/weather_weekly_list.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final weatherService = ref.watch(weatherServiceProvider);
    final weatherDataAsyncValue = ref.watch(weatherDataFutureProvider);
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
        child: weatherDataAsyncValue.when(
          data: (weatherData) => Column(
            children: <Widget>[
              WeatherDayWidget(weatherData: weatherData),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Hourly Forecast',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              const WeatherHourlyList(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text(
                  'Weekly Forecast',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              WeatherWeeklyList(weatherService: weatherService),
            ],
          ),
          loading: () => const CircularProgressIndicator(),
          error: (error, _) => Text("$error"),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => ref.refresh(weatherDataFutureProvider),
      ),
    );
  }
}
