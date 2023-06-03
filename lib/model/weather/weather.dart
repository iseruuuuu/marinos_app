import 'package:json_annotation/json_annotation.dart';

part 'weather.g.dart';

@JsonSerializable()
class Weather {
  @JsonKey(name: 'dt')
  final int date;

  @JsonKey(name: 'temp')
  final Temperature temperature;

  final List<WeatherCondition> weather;

  @JsonKey(name: 'rain')
  final double? rainVolume;

  Weather({
    required this.date,
    required this.temperature,
    required this.weather,
    this.rainVolume,
  });

  factory Weather.fromJson(Map<String, dynamic> json) =>
      _$WeatherFromJson(json);
}

@JsonSerializable()
class WeatherCondition {
  final String main;
  final String description;

  WeatherCondition({required this.main, required this.description});

  factory WeatherCondition.fromJson(Map<String, dynamic> json) =>
      _$WeatherConditionFromJson(json);
}

@JsonSerializable()
class Temperature {
  final double day;
  final double min;
  final double max;

  Temperature({
    required this.day,
    required this.min,
    required this.max,
  });

  factory Temperature.fromJson(Map<String, dynamic> json) =>
      _$TemperatureFromJson(json);
}
