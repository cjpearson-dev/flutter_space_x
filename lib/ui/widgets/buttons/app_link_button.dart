import 'package:flutter/cupertino.dart';
import 'package:flutter_space_x/injection/setup_locator.dart';
import 'package:flutter_space_x/services/url_launcher/url_launcher_service.dart';

import 'app_text_button.dart';

class AppLinkButton extends StatelessWidget {
  final String text;

  final String urlString;

  const AppLinkButton({super.key, required this.text, required this.urlString});

  @override
  Widget build(BuildContext context) {
    return AppTextButton(
      text: text,
      onPressed: () => _generateUrlLauncherCallback(urlString),
    );
  }

  Future<bool> _generateUrlLauncherCallback(String url) {
    return locator<UrlLauncherService>().openUrl(url);
  }
}
