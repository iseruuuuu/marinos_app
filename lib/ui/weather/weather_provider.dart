import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marinos_app/api/weather_api.dart';

final weatherApiProvider = Provider<WeatherApi>((ref) {
  return WeatherApi();
});
