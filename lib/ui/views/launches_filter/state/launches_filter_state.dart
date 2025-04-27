part of 'launches_filter_cubit.dart';

@freezed
abstract class LaunchesFilterState with _$LaunchesFilterState {
  const factory LaunchesFilterState({
    required DataLoadingStatus loadingStatus,
    List<LaunchRocket>? content,
    String? error,
  }) = _LaunchesFilterState;
}
