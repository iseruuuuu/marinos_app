import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final transportationProvider = StateProvider<InAppWebViewController?>(
  (ref) => null,
);
