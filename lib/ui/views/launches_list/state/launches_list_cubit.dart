import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_x/injection/setup_locator.dart';
import 'package:flutter_space_x/models/launch.dart';
import 'package:flutter_space_x/repositories/data_loading_status.dart';
import 'package:flutter_space_x/repositories/launches/launches_repository.dart';
import 'package:flutter_space_x/services/navigation/navigation_service.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'launches_list_cubit.freezed.dart';
part 'launches_list_state.dart';

final class LaunchesListCubit extends Cubit<LaunchesListState> {
  final _historyRepository = locator<LaunchesRepository>();

  final _navigationService = locator<NavigationService>();

  LaunchesListCubit()
    : super(LaunchesListState(loadingStatus: DataLoadingStatus.initial));

  // The amount of results to fetch at one time.
  final limit = 10;

  // This method will trigger once when the class is constructed by the BlocProvider,
  // then subsequently when the user pulls down to refresh.
  Future<void> load({bool refresh = false}) async {
    // On first load set status to [loading], else [refreshing]:
    // While loading, a full screen progress indicator will appear until content is fetched.
    // While refreshing, content is preserved while data refreshes in the background. A refresh indicator will appear atop the existing content.
    emit(
      state.copyWith(
        loadingStatus:
            !refresh ? DataLoadingStatus.loading : DataLoadingStatus.refreshing,
      ),
    );

    final response = await _historyRepository.getPastLaunches(
      limit: limit,
      offset: 0,
      year: state.yearFilter,
      rocketId: state.rocketIdFilter,
      siteId: state.launchSiteIdFilter,
    );

    if (response.isSuccessful) {
      emit(
        state.copyWith(
          loadingStatus: DataLoadingStatus.success,
          content: response.content,
          maxCount: response.maxCount,
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

  // This method will trigger when the user has scrolled toward the bottom of the page,
  // fetching more results and appending them to state.
  Future<void> loadMore() async {
    emit(state.copyWith(isLoadingMore: true));
    // Pass in the current content list length as the offset -
    // this is a little naive if you've got data that is likely to update regularly but
    // is sufficient for this demonstration.
    final response = await _historyRepository.getPastLaunches(
      limit: limit,
      offset: state.content?.length,
      year: state.yearFilter,
      rocketId: state.rocketIdFilter,
      siteId: state.launchSiteIdFilter,
    );

    if (response.isSuccessful) {
      // Combine the latest fetched data with the existing
      final Set<Launch> combinedLaunches = {
        ...state.content ?? [],
        ...response.content ?? [],
      };

      emit(
        state.copyWith(
          loadingStatus: DataLoadingStatus.success,
          content: combinedLaunches.toList(),
          isLoadingMore: false,
        ),
      );
    } else {
      emit(
        state.copyWith(
          loadingStatus: DataLoadingStatus.failure,
          error: response.message,
          isLoadingMore: false,
        ),
      );
    }
  }

  void onYearChanged(int? year) {
    emit(state.copyWith(yearFilter: year));
  }

  void onRocketSelected(String? rocketId) {
    emit(state.copyWith(rocketIdFilter: rocketId));
  }

  void onLaunchSiteSelected(String? siteId) {
    emit(state.copyWith(launchSiteIdFilter: siteId));
  }

  void resetFilters() {
    emit(
      state.copyWith(
        yearFilter: null,
        rocketIdFilter: null,
        launchSiteIdFilter: null,
      ),
    );
    load();
  }

  bool onScrollNotification(ScrollNotification scrollInfo) {
    // Tweak this value as necessary to get as seamless a lazy loading scroll as possible.
    final double triggerOffset = 300; // Trigger refresh when 300px from bottom

    // This will trigger when the user approaches the bottom of the currently loaded list,
    // as long as there are more results to fetch and background fetching isn't already happening.
    final hasMore =
        state.content != null && state.content!.length < (state.maxCount ?? 0);

    if (hasMore &&
        !state.isLoadingMore &&
        scrollInfo.metrics.pixels >=
            scrollInfo.metrics.maxScrollExtent - triggerOffset) {
      loadMore();
      return true;
    }
    return false;
  }

  Future<void> navigateToEventDetails(int flightNumber) =>
      _navigationService.navigateToLaunchDetails(flightNumber);
}
