import '../../models/launch.dart';
import '../data_response.dart';

abstract interface class RocketRepository {
  Future<DataResponse<List<LaunchRocket>>> getRocketsBasic();
}
