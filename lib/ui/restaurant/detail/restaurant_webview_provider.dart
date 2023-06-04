import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final restaurantWebViewProvider = StateProvider<InAppWebViewController?>(
  (_) => null,
);

final restaurantIsLoadingProvider =
    StateNotifierProvider<RestaurantLoadingNotifier, bool>(
  (_) => RestaurantLoadingNotifier(),
);

class RestaurantLoadingNotifier extends StateNotifier<bool> {
  RestaurantLoadingNotifier() : super(false);

  void setLoading(bool isLoading) {
    state = isLoading;
  }
}
