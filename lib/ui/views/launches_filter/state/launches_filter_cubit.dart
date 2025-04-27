import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_x/injection/setup_locator.dart';
import 'package:flutter_space_x/models/launch.dart';
import 'package:flutter_space_x/repositories/data_loading_status.dart';
import 'package:flutter_space_x/repositories/rockets/rocket_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'launches_filter_cubit.freezed.dart';
part 'launches_filter_state.dart';

final class LaunchesFilterCubit extends Cubit<LaunchesFilterState> {
  final _rocketRepository = locator<RocketRepository>();

  LaunchesFilterCubit()
    : super(LaunchesFilterState(loadingStatus: DataLoadingStatus.initial));

  Future<void> load({bool refresh = false}) async {
    emit(state.copyWith(loadingStatus: DataLoadingStatus.loading));

    final response = await _rocketRepository.getRocketsBasic();

    if (response.isSuccessful) {
      emit(
        state.copyWith(
          loadingStatus: DataLoadingStatus.success,
          content: response.content!,
        ),
      );
    } else {
      emit(
        state.copyWith(
          loadingStatus: DataLoadingStatus.failure,
          error: response.message,
        ),
      );
    }
  }
}
