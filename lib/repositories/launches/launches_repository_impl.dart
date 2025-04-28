import 'package:flutter/material.dart';
import 'package:flutter_space_x/models/launch.dart';
import 'package:flutter_space_x/services/api/api.dart';

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
    String? rocketId,
    String? siteId,
  }) async {
    final url = SpaceXRepository.constructUrl(
      'launches/past',
      queryParameters: {
        'order': 'desc',
        if (limit != null) 'limit': '$limit',
        if (offset != null) 'offset': '$offset',
        if (year != null) 'launch_year': '$year',
        if (rocketId != null) 'rocket_id': rocketId,
        if (siteId != null) 'site_id': siteId,
      },
    );
    final response = await _apiService.get(url: url);

    switch (response) {
      case ApiResponseSuccess(:final headers, :final data):
        final events = <Launch>[];

        for (var jsonItem in data) {
          events.add(Launch.fromJson(jsonItem));
        }
        final count =
            headers[SpaceXRepository.countHeaderKey] != null
                ? int.tryParse(headers[SpaceXRepository.countHeaderKey]!)
                : null;

        return DataResponse.success(events, count);
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

  @override
  Future<DataResponse<List<LaunchSiteDetail>>> getLaunchSites() async {
    final url = SpaceXRepository.constructUrl(
      'launchpads',
      queryParameters: {
        'filter': 'name,site_id,site_name_long,attempted_launches',
      },
    );
    final response = await _apiService.get(url: url);

    switch (response) {
      case ApiResponseSuccess(:final data):
        try {
          final launchPads = <LaunchSiteDetail>[];

          for (var jsonItem in data) {
            launchPads.add(LaunchSiteDetail.fromJson(jsonItem));
          }

          // Filter out sites that have no launches.
          final filteredLaunchPads =
              launchPads.where((pad) => pad.attemptedLaunches > 0).toList();

          return DataResponse.success(filteredLaunchPads);
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
