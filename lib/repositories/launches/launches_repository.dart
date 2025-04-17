import 'package:flutter_space_x/models/launch.dart';

import '../data_response.dart';

abstract interface class LaunchesRepository {
  Future<DataResponse<List<Launch>>> getUpcomingLaunches();

  Future<DataResponse<List<Launch>>> getPastLaunches();

  Future<DataResponse<Launch>> getSingleLaunch(int flightNumber);
}
