import 'package:flutter/foundation.dart';

import '../../models/historical_event.dart';
import '../../services/api/api.dart';
import '../data_response.dart';
import '../space_x_repository.dart';
import 'history_repository.dart';

final class HistoryRepositoryImpl implements HistoryRepository {
  final ApiService _apiService;

  HistoryRepositoryImpl(this._apiService);

  @override
  Future<DataResponse<List<HistoricalEvent>>> getAllEvents() async {
    final url = SpaceXRepository.constructUrl(
      'history',
      queryParameters: {'order': 'desc'},
    );
    final response = await _apiService.get(url: url);

    switch (response) {
      case ApiResponseSuccess(:final data):
        try {
          final events = <HistoricalEvent>[];

          for (var jsonItem in data) {
            events.add(HistoricalEvent.fromJson(jsonItem));
          }

          return DataResponse.success(events);
        } on TypeError {
          debugPrint('Json parsing error');
          // TODO: Localise this string
          return DataResponse.failure('Something went wrong');
        }
      case ApiResponseError(:final message):
        return DataResponse.failure(message);
    }
  }

  @override
  Future<DataResponse<HistoricalEvent>> getSingleEvent(int id) async {
    final url = SpaceXRepository.constructUrl('history/$id');
    final response = await _apiService.get(url: url);

    switch (response) {
      case ApiResponseSuccess(:final data):
        try {
          final event = HistoricalEvent.fromJson(data);

          return DataResponse.success(event);
        } on TypeError {
          debugPrint('Json parsing error');
          // TODO: Localise this string
          return DataResponse.failure('Something went wrong');
        }
      case ApiResponseError(:final message):
        return DataResponse.failure(message);
    }
  }
}
