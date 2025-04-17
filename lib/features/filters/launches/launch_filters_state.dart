part of 'launch_filters_cubit.dart';

@freezed
abstract class LaunchFiltersState with _$LaunchFiltersState {
  const factory LaunchFiltersState({int? selectedYear}) = _LaunchFiltersState;
}
