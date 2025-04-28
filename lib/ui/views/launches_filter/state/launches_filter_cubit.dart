import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_x/injection/setup_locator.dart';
import 'package:flutter_space_x/models/launch.dart';
import 'package:flutter_space_x/repositories/data_loading_status.dart';
import 'package:flutter_space_x/repositories/data_response.dart';
import 'package:flutter_space_x/repositories/launches/launches_repository.dart';
import 'package:flutter_space_x/repositories/rockets/rocket_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'launches_filter_cubit.freezed.dart';
part 'launches_filter_state.dart';

final class LaunchesFilterCubit extends Cubit<LaunchesFilterState> {
  final _launchesRepository = locator<LaunchesRepository>();
  final _rocketRepository = locator<RocketRepository>();

  LaunchesFilterCubit()
    : super(LaunchesFilterState(loadingStatus: DataLoadingStatus.initial));

  Future<void> load({bool refresh = false}) async {
    emit(state.copyWith(loadingStatus: DataLoadingStatus.loading));

    final responses = await Future.wait<DataResponse<List>>([
      _rocketRepository.getRocketsBasic(),
      _launchesRepository.getLaunchSites(),
    ]);

    if (responses.every((response) => response.isSuccessful)) {
      emit(
        state.copyWith(
          loadingStatus: DataLoadingStatus.success,
          rockets: responses[0].content! as List<LaunchRocket>,
          launchPads: responses[1].content! as List<LaunchSiteDetail>,
        ),
      );
    } else {
      emit(
        state.copyWith(
          loadingStatus: DataLoadingStatus.failure,
          error: responses[0].message ?? responses[1].message,
        ),
      );
    }
  }
}
