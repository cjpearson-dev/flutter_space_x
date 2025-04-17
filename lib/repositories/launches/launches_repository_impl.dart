import '../../models/launch.dart';
import '../../services/api/api.dart';
import '../data_response.dart';
import 'launches_repository.dart';

final class LaunchesRepositoryImpl implements LaunchesRepository {
  final ApiService _apiService;

  LaunchesRepositoryImpl(this._apiService);

  // Would have this in an .env file if it wasn't a publicly accessible API.
  final _baseUrl = 'api.spacexdata.com';
  final _basePath = '/v3';

  @override
  Future<DataResponse<List<Launch>>> getUpcomingLaunches() async {
    final url = _constructUrl('launches/upcoming');
    final response = await _apiService.get(url: url);

    switch (response) {
      case ApiResponseSuccess(:final data):
        final events = <Launch>[];

        for (var jsonItem in data) {
          events.add(Launch.fromJson(jsonItem));
        }

        return DataResponse.success(events);
      case ApiResponseError(:final message):
        return DataResponse.failure(message);
    }
  }

  @override
  Future<DataResponse<List<Launch>>> getPastLaunches({
    int? limit,
    int? offset,
    int? year,
  }) async {
    final url = _constructUrl(
      'launches/past',
      queryParameters: {
        'order': 'desc',
        if (limit != null) 'limit': '$limit',
        if (offset != null) 'offset': '$offset',
        if (year != null) 'launch_year': '$year',
      },
    );
    final response = await _apiService.get(url: url);

    switch (response) {
      case ApiResponseSuccess(:final data):
        final events = <Launch>[];

        for (var jsonItem in data) {
          events.add(Launch.fromJson(jsonItem));
        }

        return DataResponse.success(events);
      case ApiResponseError(:final message):
        return DataResponse.failure(message);
    }
  }

  @override
  Future<DataResponse<Launch>> getSingleLaunch(int flightNumber) async {
    final url = _constructUrl('launches/$flightNumber');
    final response = await _apiService.get(url: url);

    switch (response) {
      case ApiResponseSuccess(:final data):
        final event = Launch.fromJson(data);

        return DataResponse.success(event);
      case ApiResponseError(:final message):
        return DataResponse.failure(message);
    }
  }

  Uri _constructUrl(String path, {Map<String, String>? queryParameters}) =>
      Uri.https(_baseUrl, '$_basePath/$path', queryParameters);
}
