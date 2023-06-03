import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class TransportationIconButton extends StatelessWidget {
  const TransportationIconButton({
    super.key,
    required this.transportation,
    required this.future,
    required this.icon,
  });

  final StateController<InAppWebViewController?> transportation;
  final Future<bool>? future;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: future,
      builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return IconButton(
            onPressed: null,
            icon: Icon(
              icon,
              color: Colors.grey,
            ),
          );
        }
        if (snapshot.hasError) {
          return IconButton(
            onPressed: null,
            icon: Icon(
              icon,
              color: Colors.grey,
            ),
          );
        } else {
          return IconButton(
            onPressed: () => transportation.state!.goBack(),
            icon: Icon(
              icon,
              color: snapshot.data! ? Colors.black : Colors.grey,
            ),
          );
        }
      },
    );
  }
}
