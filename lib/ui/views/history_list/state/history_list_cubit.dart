import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_x/injection/setup_locator.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/historical_event.dart';
import '../../../../repositories/data_loading_status.dart';
import '../../../../repositories/history/history_repository.dart';

part 'history_list_cubit.freezed.dart';
part 'history_list_state.dart';

final class HistoryListCubit extends Cubit<HistoryListState> {
  final _historyRepository = locator<HistoryRepository>();

  HistoryListCubit()
    : super(HistoryListState(loadingStatus: DataLoadingStatus.initial));

  Future<void> load() async {
    emit(state.copyWith(loadingStatus: DataLoadingStatus.loading));

    final response = await _historyRepository.getAllEvents();

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
