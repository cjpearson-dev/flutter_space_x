import '../../models/historical_event.dart';
import '../data_response.dart';

abstract interface class HistoryRepository {
  Future<DataResponse<List<HistoricalEvent>>> getAllEvents();

  Future<DataResponse<HistoricalEvent>> getSingleEvent(int id);
}
