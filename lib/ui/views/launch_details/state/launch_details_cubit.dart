import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_x/injection/setup_locator.dart';
import 'package:flutter_space_x/models/launch.dart';
import 'package:flutter_space_x/repositories/data_loading_status.dart';
import 'package:flutter_space_x/repositories/launches/launches_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'launch_details_cubit.freezed.dart';
part 'launch_details_state.dart';

final class LaunchDetailsCubit extends Cubit<LaunchDetailsState> {
  final _launchesRepository = locator<LaunchesRepository>();

  LaunchDetailsCubit()
    : super(LaunchDetailsState(loadingStatus: DataLoadingStatus.initial));

  Future<void> load(int flightNumber) async {
    // On first load set status to [loading], else [refreshing]:
    // While loading, a full screen progress indicator will appear until content is fetched.
    // While refreshing, content is preserved while data refreshes in the background. A refresh indicator will appear atop the existing content.
    emit(
      state.copyWith(
        loadingStatus:
            state.loadingStatus == DataLoadingStatus.initial
                ? DataLoadingStatus.loading
                : DataLoadingStatus.refreshing,
      ),
    );

    final response = await _launchesRepository.getSingleLaunch(flightNumber);

    if (response.isSuccessful) {
      emit(
        state.copyWith(
          loadingStatus: DataLoadingStatus.success,
          content: response.content,
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
