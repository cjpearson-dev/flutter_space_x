part of 'launches_list_cubit.dart';

@freezed
abstract class LaunchesListState with _$LaunchesListState {
  const factory LaunchesListState({
    required DataLoadingStatus loadingStatus,
    List<Launch>? content,
    String? error,
    @Default(false) bool outOfResults,
    @Default(false) bool isLoadingMore,
    int? yearFilter,
    String? rocketIdFilter,
    String? launchSiteIdFilter,
  }) = _LaunchesListState;
}
