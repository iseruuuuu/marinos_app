import 'package:flutter/material.dart';
import '../../../utils/weather_util.dart';


class WeatherDayWidget extends StatelessWidget {
  const WeatherDayWidget({
    super.key,
    required Map<String, dynamic> weatherData,
  }) : _weatherData = weatherData;

  final Map<String, dynamic> _weatherData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: 50,
              height: 50,
              child: Image.network(
                WeatherUtils().getWeatherImage(
                  '${_weatherData['weather'][0]['main']}',
                ),
              ),
            ),
            Text(
              WeatherUtils().getWeather(
                '${_weatherData['weather'][0]['main']}',
              ),
              style: const TextStyle(
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
                const Text('現在の気温'),
                Text(
                  ' ${_weatherData['main']['temp']}°C',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Column(
              children: [
                const Text('湿度'),
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
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                const Text('最高気温'),
                Text(
                  '${_weatherData['main']['temp_max']}°C',
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
                  '${_weatherData['main']['temp_min']}°C',
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
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
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
                  '${_weatherData['main']['pressure']} Pa',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}