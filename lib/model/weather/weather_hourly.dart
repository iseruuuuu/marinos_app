class WeatherHourly {
  final int timestamp;
  final double temperature;
  final String mainWeather;
  final String iconId;
  final double rainVolume;

  WeatherHourly({
    required this.timestamp,
    required this.temperature,
    required this.mainWeather,
    required this.iconId,
    required this.rainVolume,
  });

  factory WeatherHourly.fromJson(Map<String, dynamic> json) {
    return WeatherHourly(
      timestamp: json['dt'],
      temperature: json['temp'].toDouble(),
      mainWeather: json['weather'][0]['main'],
      iconId: json['weather'][0]['icon'],
      rainVolume: json['rain'] != null ? json['rain']['1h'].toDouble() : 0.0,
    );
  }
}
