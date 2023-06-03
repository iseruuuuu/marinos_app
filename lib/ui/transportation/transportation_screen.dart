import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marinos_app/ui/transportation/transportation_provider.dart';
import 'package:url_launcher/url_launcher.dart';

class TransportationScreen extends ConsumerWidget {
  const TransportationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transportation = ref.watch(transportationProvider.notifier);
    return SafeArea(
      top: false,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
        ),
        body: Column(
          children: [
            Expanded(
              child: InAppWebView(
                onWebViewCreated: (controller) {
                  transportation.state = controller;
                },
                initialUrlRequest:
                    URLRequest(url: Uri.parse('https://transit.yahoo.co.jp/')),
                initialOptions: InAppWebViewGroupOptions(
                  crossPlatform: InAppWebViewOptions(
                    transparentBackground: true,
                    useShouldOverrideUrlLoading: true,
                    clearCache: true,
                    cacheEnabled: false,
                  ),
                ),
                shouldOverrideUrlLoading: (controller, navigationAction) async {
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
                  IconButton(
                    onPressed: () => transportation.state!.goBack(),
                    icon: const Icon(Icons.arrow_back_ios_new),
                  ),
                  IconButton(
                    onPressed: () => transportation.state!.goForward(),
                    icon: const Icon(Icons.arrow_forward_ios),
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
      ),
    );
  }
}
