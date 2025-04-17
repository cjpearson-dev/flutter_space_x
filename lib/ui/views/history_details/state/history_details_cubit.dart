import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_x/injection/setup_locator.dart';
import 'package:flutter_space_x/models/historical_event.dart';
import 'package:flutter_space_x/repositories/data_loading_status.dart';
import 'package:flutter_space_x/repositories/history/history_repository.dart';
import 'package:flutter_space_x/services/navigation/navigation_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_details_cubit.freezed.dart';
part 'history_details_state.dart';

final class HistoryDetailsCubit extends Cubit<HistoryDetailsState> {
  final _historyRepository = locator<HistoryRepository>();

  final _navigationService = locator<NavigationService>();

  HistoryDetailsCubit()
    : super(HistoryDetailsState(loadingStatus: DataLoadingStatus.initial));

  Future<void> load(int id) async {
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

    final response = await _historyRepository.getSingleEvent(id);

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

  Future<void> navigateToEventDetails(int flightNumber) =>
      _navigationService.navigateToLaunchDetails(flightNumber);
}
