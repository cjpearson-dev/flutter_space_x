part of 'history_list_cubit.dart';

@freezed
abstract class HistoryListState with _$HistoryListState {
  const factory HistoryListState({
    required DataLoadingStatus loadingStatus,
    List<HistoricalEvent>? content,
    String? error,
  }) = _HistoryListState;
}
