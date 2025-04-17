import 'package:flutter_space_x/services/url_launcher/url_launcher_service.dart';
import 'package:url_launcher/url_launcher.dart';

class UrlLauncherServiceImpl implements UrlLauncherService {
  @override
  Future<bool> openUrl(
    String baseUrl, [
    Map<String, dynamic>? queryParameters,
  ]) async {
    final uri = Uri.parse(baseUrl);
    if (queryParameters != null) {
      uri.replace(queryParameters: queryParameters);
    }

    final result = await launchUrl(
      uri,
      mode: LaunchMode.externalNonBrowserApplication,
    ).catchError((_) => false);

    return result
        ? result
        : await launchUrl(
          uri,
          mode: LaunchMode.inAppWebView,
        ).catchError((_) => false);
  }
}
