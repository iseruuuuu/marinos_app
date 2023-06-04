import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final transportationProvider = StateProvider<InAppWebViewController?>(
  (_) => null,
);

final transportationLoadingProvider =
    StateNotifierProvider<TransportationLoadingNotifier, bool>(
  (_) => TransportationLoadingNotifier(),
);

class TransportationLoadingNotifier extends StateNotifier<bool> {
  TransportationLoadingNotifier() : super(false);

  void setLoading(bool isLoading) {
    state = isLoading;
  }
}
