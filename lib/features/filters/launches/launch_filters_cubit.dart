import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'launch_filters_cubit.freezed.dart';
part 'launch_filters_state.dart';

class LaunchFiltersCubit extends Cubit<LaunchFiltersState> {
  LaunchFiltersCubit() : super(LaunchFiltersState());

  void onYearChanged(int? year) {
    emit(state.copyWith(selectedYear: year));
  }
}
