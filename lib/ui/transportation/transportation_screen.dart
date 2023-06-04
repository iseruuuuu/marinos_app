import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marinos_app/ui/transportation/transportation_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../component/app_icon_button.dart';

class TransportationScreen extends ConsumerWidget {
  const TransportationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transportation = ref.watch(transportationProvider.notifier);
    final isLoading = ref.watch(transportationLoadingProvider);
    return SafeArea(
      top: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: const Text(
            '交通案内',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: InAppWebView(
                    onWebViewCreated: (controller) {
                      transportation.state = controller;
                    },
                    onLoadStart: (controller, url) {
                      ref
                          .read(transportationLoadingProvider.notifier)
                          .setLoading(true);
                    },
                    onLoadStop: (controller, url) {
                      ref
                          .read(transportationLoadingProvider.notifier)
                          .setLoading(false);
                    },
                    initialUrlRequest: URLRequest(
                      url: Uri.parse(
                        'https://transit.yahoo.co.jp/',
                      ),
                    ),
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
                        stateController: transportation,
                        future: transportation.state?.canGoBack() ??
                            Future.value(false),
                        icon: Icons.arrow_back_ios_new,
                      ),
                      AppIconButton(
                        stateController: transportation,
                        future: transportation.state?.canGoForward() ??
                            Future.value(false),
                        icon: Icons.arrow_forward_ios,
                      ),
                      IconButton(
                        onPressed: () => transportation.state!.reload(),
                        icon: const Icon(Icons.refresh),
                      ),
                      IconButton(
                        onPressed: () => transportation.state!.loadUrl(
                          urlRequest: URLRequest(
                            url: Uri.parse('https://transit.yahoo.co.jp/'),
                          ),
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
