part of 'launches_list_cubit.dart';

@freezed
abstract class LaunchesListState with _$LaunchesListState {
  const factory LaunchesListState({
    required DataLoadingStatus loadingStatus,
    List<Launch>? content,
    String? error,
  }) = _LaunchesListState;
}
