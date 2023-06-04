import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

final settingProvider = StateNotifierProvider<SettingViewModel, String>((ref) {
  return SettingViewModel();
});

class SettingViewModel extends StateNotifier<String> {
  SettingViewModel() : super('') {
    loadVersion();
  }

  Future<void> loadVersion() async {
    final packageInfo = await PackageInfo.fromPlatform();
    state = packageInfo.version;
  }

  Future<void> onTapReview() async {
    final inAppReview = InAppReview.instance;
    if (await inAppReview.isAvailable()) {
      await inAppReview.requestReview();
    }
  }

  Future<void> onTapMail() async {
    final url = Uri.parse('https://forms.gle/57XGrc1ThShbAuMn6');
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  Future<void> onTapTwitter() async {
    final url = Uri.parse('https://twitter.com/isekiryu');
    final secondUrl = Uri.parse('https://twitter.com/isekiryu');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else if (await canLaunchUrl(secondUrl)) {
      await launchUrl(secondUrl);
    }
  }

  void onTapLicense(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const LicensePage(),
      ),
    );
  }

  Future<void> onTapGithub() async {
    final Uri url = Uri.parse('https://github.com/iseruuuuu/marinos_app');
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

// void onTapShare() {
//   if (Platform.isAndroid) {
//     Share.share(
//         'https://play.google.com/store/apps/details?id=com.hinatazaka_fan_app');
//   } else {
//     Share.share(
//         'https://apps.apple.com/jp/app/%E3%81%B2%E3%81%AA%E3%83%95%E3%82%A1%E3%83%B3/id6447280230');
//   }
// }
}
