import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marinos_app/ui/restaurant/detail/restaurant_webview_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../component/app_icon_button.dart';

class RestaurantWebViewScreen extends ConsumerWidget {
  const RestaurantWebViewScreen({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final restaurant = ref.watch(restaurantWebViewProvider.notifier);
    final isLoading = ref.watch(restaurantIsLoadingProvider);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: InAppWebView(
                    onWebViewCreated: (controller) {
                      restaurant.state = controller;
                    },
                    onLoadStart: (controller, url) {
                      ref
                          .read(restaurantIsLoadingProvider.notifier)
                          .setLoading(true);
                    },
                    onLoadStop: (controller, url) {
                      ref
                          .read(restaurantIsLoadingProvider.notifier)
                          .setLoading(false);
                    },
                    initialUrlRequest: URLRequest(url: Uri.parse(url)),
                    initialOptions: InAppWebViewGroupOptions(
                      crossPlatform: InAppWebViewOptions(
                        transparentBackground: true,
                        useShouldOverrideUrlLoading: true,
                        clearCache: true,
                        cacheEnabled: false,
                      ),
                    ),
                    shouldOverrideUrlLoading:
                        (controller, navigationAction) async {
                      var uri = navigationAction.request.url!;
                      if (![
                        "http",
                        "https",
                        "file",
                        "chrome",
                        "data",
                        "javascript",
                        "about"
                      ].contains(uri.scheme)) {
                        if (await canLaunchUrl(uri)) {
                          await launchUrl(
                            uri,
                          );
                          return NavigationActionPolicy.CANCEL;
                        }
                      }
                      return NavigationActionPolicy.ALLOW;
                    },
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    border: Border(
                      top: BorderSide(width: 0, color: Colors.black),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      AppIconButton(
                        stateController: restaurant,
                        future: restaurant.state?.canGoBack() ??
                            Future.value(false),
                        icon: Icons.arrow_back_ios_new,
                      ),
                      AppIconButton(
                        stateController: restaurant,
                        future: restaurant.state?.canGoForward() ??
                            Future.value(false),
                        icon: Icons.arrow_forward_ios,
                      ),
                      IconButton(
                        onPressed: () => restaurant.state!.reload(),
                        icon: const Icon(Icons.refresh),
                      ),
                      IconButton(
                        onPressed: () => restaurant.state!.loadUrl(
                          urlRequest: URLRequest(url: Uri.parse(url)),
                        ),
                        icon: const Icon(Icons.home),
                      ),
                    ],
                  ),
                )
              ],
            ),
            if (isLoading)
              const Center(
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: CircularProgressIndicator(
                    strokeWidth: 8,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
