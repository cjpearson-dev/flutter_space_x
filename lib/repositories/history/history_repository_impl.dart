import '../../models/historical_event.dart';
import '../../services/api/api.dart';
import '../data_response.dart';
import 'history_repository.dart';

final class HistoryRepositoryImpl implements HistoryRepository {
  final ApiService _apiService;

  HistoryRepositoryImpl(this._apiService);

  // Would have this in an .env file if it wasn't a publicly accessible API.
  final _baseUrl = 'api.spacexdata.com';
  final _basePath = '/v3';

  @override
  Future<DataResponse<List<HistoricalEvent>>> getAllEvents() async {
    final url = _constructUrl('history');
    final response = await _apiService.get(url: url);

    switch (response) {
      case ApiResponseSuccess(:final data):
        final events = <HistoricalEvent>[];

        for (var jsonItem in data) {
          events.add(HistoricalEvent.fromJson(jsonItem));
        }

        return DataResponse.success(events);
      case ApiResponseError(:final message):
        return DataResponse.failure(message);
    }
  }

  @override
  Future<DataResponse<HistoricalEvent>> getSingleEvent(int id) async {
    final url = _constructUrl('history/$id');
    final response = await _apiService.get(url: url);

    switch (response) {
      case ApiResponseSuccess(:final data):
        final event = HistoricalEvent.fromJson(data);

        return DataResponse.success(event);
      case ApiResponseError(:final message):
        return DataResponse.failure(message);
    }
  }

  Uri _constructUrl(String path, {Map<String, String>? queryParameters}) =>
      Uri.https(_baseUrl, '$_basePath/$path', queryParameters);
}
