part of 'launches_filter_cubit.dart';

@freezed
abstract class LaunchesFilterState with _$LaunchesFilterState {
  const factory LaunchesFilterState({
    required DataLoadingStatus loadingStatus,
    List<LaunchRocket>? rockets,
    List<LaunchSiteDetail>? launchPads,
    String? error,
  }) = _LaunchesFilterState;
}
