class SpaceXRepository {
  static Uri constructUrl(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) => Uri.https('api.spacexdata.com', '/v3/$path', queryParameters);
}
