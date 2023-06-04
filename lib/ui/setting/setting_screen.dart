import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:marinos_app/ui/setting/setting_provider.dart';
import 'package:settings_ui/settings_ui.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF2F2F7),
        title: const Text(
          '設定',
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SettingsList(
              lightTheme: const SettingsThemeData(
                settingsListBackground: Color(0xFFF2F2F7),
                settingsSectionBackground: Colors.white,
              ),
              sections: [
                SettingsSection(
                  title: const Text('このアプリについて'),
                  tiles: [
                    SettingsTile.navigation(
                      leading: const Icon(
                        MaterialIcons.star,
                        color: Colors.yellow,
                      ),
                      title: const Text('レビューを書く'),
                      onPressed: (context) {
                        ref.read(settingProvider.notifier).onTapReview();
                      },
                    ),
                    // SettingsTile.navigation(
                    //   leading: const Icon(
                    //     Entypo.share,
                    //     color: Colors.black,
                    //   ),
                    //   title: const Text('友達に教える'),
                    //   onPressed: (context) {
                    //     ref
                    //         .read(settingViewModelProvider.notifier)
                    //         .onTapShare();
                    //   },
                    // ),
                    SettingsTile.navigation(
                      leading: const Icon(
                        Icons.mail,
                        color: Colors.lightBlue,
                      ),
                      title: const Text('このアプリのお問い合わせ'),
                      onPressed: (context) {
                        ref.read(settingProvider.notifier).onTapMail();
                      },
                    ),
                    SettingsTile.navigation(
                      leading: const Icon(
                        AntDesign.twitter,
                        color: Colors.blueAccent,
                      ),
                      title: const Text('開発者のアカウント'),
                      onPressed: (context) {
                        ref.read(settingProvider.notifier).onTapTwitter();
                      },
                    ),
                    SettingsTile.navigation(
                      leading: const Icon(
                        Icons.local_police,
                        color: Colors.grey,
                      ),
                      title: const Text('ライセンス'),
                      onPressed: (context) {
                        ref
                            .read(settingProvider.notifier)
                            .onTapLicense(context);
                      },
                    ),
                    SettingsTile.navigation(
                      leading: const Icon(
                        MaterialCommunityIcons.github,
                        color: Colors.black,
                      ),
                      title: const Text('Github'),
                      onPressed: (context) {
                        ref.read(settingProvider.notifier).onTapGithub();
                      },
                    ),
                    SettingsTile.navigation(
                      title: const Text('バージョン'),
                      trailing: Text(ref.watch(settingProvider)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
