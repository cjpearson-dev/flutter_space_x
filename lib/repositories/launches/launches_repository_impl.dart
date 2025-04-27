import '../../models/launch.dart';
import '../../services/api/api.dart';
import '../data_response.dart';
import '../space_x_repository.dart';
import 'launches_repository.dart';

final class LaunchesRepositoryImpl implements LaunchesRepository {
  final ApiService _apiService;

  LaunchesRepositoryImpl(this._apiService);

  @override
  Future<DataResponse<List<Launch>>> getUpcomingLaunches() async {
    final url = SpaceXRepository.constructUrl('launches/upcoming');
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
    final url = SpaceXRepository.constructUrl(
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
    final url = SpaceXRepository.constructUrl('launches/$flightNumber');
    final response = await _apiService.get(url: url);

    switch (response) {
      case ApiResponseSuccess(:final data):
        final event = Launch.fromJson(data);

        return DataResponse.success(event);
      case ApiResponseError(:final message):
        return DataResponse.failure(message);
    }
  }
}
