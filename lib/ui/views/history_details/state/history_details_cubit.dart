import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_x/injection/setup_locator.dart';
import 'package:flutter_space_x/models/historical_event.dart';
import 'package:flutter_space_x/repositories/data_loading_status.dart';
import 'package:flutter_space_x/repositories/history/history_repository.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'history_details_cubit.freezed.dart';
part 'history_details_state.dart';

final class HistoryDetailsCubit extends Cubit<HistoryDetailsState> {
  final _historyRepository = locator<HistoryRepository>();

  HistoryDetailsCubit()
    : super(HistoryDetailsState(loadingStatus: DataLoadingStatus.initial));

  Future<void> load(int id) async {
    emit(state.copyWith(loadingStatus: DataLoadingStatus.loading));

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
}
