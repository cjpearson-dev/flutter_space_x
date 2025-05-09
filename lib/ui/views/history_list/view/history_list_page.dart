import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_x/i18n/i18n.dart';
import 'package:flutter_space_x/repositories/data_loading_status.dart';
import 'package:flutter_space_x/ui/ui_helpers.dart';
import 'package:flutter_space_x/ui/widgets/widgets.dart';

import '../state/history_list_cubit.dart';

// Would ideally with more time replace these annotations with my own to decouple these views completely from auto_route.
@RoutePage()
class HistoryListPage extends StatelessWidget {
  const HistoryListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      /// Create cubit and immediately fetch data.
      create: (_) => HistoryListCubit()..load(),
      child: BlocSelector<
        HistoryListCubit,
        HistoryListState,
        (DataLoadingStatus, String?)
      >(
        /// Create a record of the required state fields.
        selector: (state) => (state.loadingStatus, state.error),
        builder: (context, state) {
          /// Create individual variables of the selected state using record destructuring.
          final (loadingStatus, error) = state;

          return DataLoadingContainer(
            onRefresh: context.read<HistoryListCubit>().load,
            loadingStatus: loadingStatus,
            successContent: _buildSuccessLayout,
            errorMessage: error,
          );
        },
      ),
    );
  }

  Widget _buildSuccessLayout(BuildContext context) {
    /// Guaranteed to have content at this point.
    final events =
        context.select((HistoryListCubit cubit) => cubit.state.content)!;

    if (events.isNotEmpty) {
      /// Show list of events if fetched and not empty.
      return ListView.builder(
        padding: const EdgeInsets.fromLTRB(kSpaceSm, kSpaceSm, kSpaceSm, 0),
        itemCount: events.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding: const EdgeInsets.only(bottom: kSpaceSm),
            child: EventListItem(
              title: events[index].title,
              text: events[index].details,
              textMaxLines: 3,
              onPress: () {
                context.read<HistoryListCubit>().navigateToEventDetails(
                  events[index].id,
                );
              },
            ),
          );
        },
      );
    } else {
      /// Show message if data fetched successfully but no results present.
      return MinHeightScrollableBody(
        child: Text(context.localizations.noResultsMsg),
      );
    }
  }
}
