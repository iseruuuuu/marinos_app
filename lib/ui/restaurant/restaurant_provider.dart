import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marinos_app/api/restaurant/restaurant_api.dart';

//レストランのリストを表示するための状態を管理します：
final restaurantProvider = FutureProvider.autoDispose<List<dynamic>>((ref) {
  final yelpService = ref.read(yelpServiceProvider);
  return yelpService.getRestaurants();
});

//YelpServiceを管理します：
final yelpServiceProvider = Provider<YelpService>((ref) => YelpService());
