abstract interface class UrlLauncherService {
  Future<bool> openUrl(String baseUrl, [Map<String, dynamic>? queryParameters]);
}
