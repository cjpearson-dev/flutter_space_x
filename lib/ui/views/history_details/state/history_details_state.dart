part of 'history_details_cubit.dart';

@freezed
abstract class HistoryDetailsState with _$HistoryDetailsState {
  const factory HistoryDetailsState({
    required DataLoadingStatus loadingStatus,
    HistoricalEvent? content,
    String? error,
  }) = _HistoryDetailsState;
}
