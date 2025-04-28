import 'package:flutter_space_x/models/launch.dart';

import '../data_response.dart';

abstract interface class LaunchesRepository {
  Future<DataResponse<List<Launch>>> getUpcomingLaunches();

  Future<DataResponse<List<Launch>>> getPastLaunches({
    int? limit,
    int? offset,
    int? year,
    String? rocketId,
    String? siteId,
  });

  Future<DataResponse<Launch>> getSingleLaunch(int flightNumber);

  Future<DataResponse<List<LaunchSiteDetail>>> getLaunchSites();
}
