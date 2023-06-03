import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final transportationProvider =
    StateProvider<InAppWebViewController?>((_) => null);

final loadingProvider = StateNotifierProvider<LoadingNotifier, bool>(
  (_) => LoadingNotifier(),
);

class LoadingNotifier extends StateNotifier<bool> {
  LoadingNotifier() : super(false);

  void setLoading(bool isLoading) {
    state = isLoading;
  }
}
