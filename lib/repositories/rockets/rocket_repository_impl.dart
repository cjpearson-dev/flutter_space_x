import 'package:flutter/foundation.dart';

import '../../models/launch.dart';
import '../../services/api/api.dart';
import '../data_response.dart';
import '../space_x_repository.dart';
import 'rocket_repository.dart';

final class RocketRepositoryImpl implements RocketRepository {
  final ApiService _apiService;

  RocketRepositoryImpl(this._apiService);

  @override
  Future<DataResponse<List<LaunchRocket>>> getRocketsBasic() async {
    final url = SpaceXRepository.constructUrl(
      'rockets',
      queryParameters: {'filter': 'rocket_id,rocket_name'},
    );
    final response = await _apiService.get(url: url);

    switch (response) {
      case ApiResponseSuccess(:final data):
        try {
          final events = <LaunchRocket>[];

          for (var jsonItem in data) {
            events.add(LaunchRocket.fromJson(jsonItem));
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
}
