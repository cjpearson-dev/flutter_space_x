part of 'launch_details_cubit.dart';

@freezed
abstract class LaunchDetailsState with _$LaunchDetailsState {
  const factory LaunchDetailsState({
    required DataLoadingStatus loadingStatus,
    Launch? content,
    String? error,
  }) = _LaunchDetailsState;
}
