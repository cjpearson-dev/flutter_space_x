import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_x/i18n/i18n.dart';
import 'package:flutter_space_x/models/historical_event.dart';
import 'package:flutter_space_x/repositories/data_loading_status.dart';
import 'package:flutter_space_x/ui/ui_helpers.dart';
import 'package:flutter_space_x/ui/widgets/widgets.dart';
import 'package:flutter_space_x/utils/date_format.dart';

import '../state/history_details_cubit.dart';

@RoutePage()
class HistoryDetailsPage extends StatelessWidget {
  final int _eventId;

  const HistoryDetailsPage(this._eventId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.localizations.historyDetailsTitle)),
      body: BlocProvider(
        /// Create cubit and immediately fetch data.
        create: (_) => HistoryDetailsCubit()..load(_eventId),
        child: BlocSelector<
          HistoryDetailsCubit,
          HistoryDetailsState,
          (DataLoadingStatus, String?)
        >(
          /// Create a record of the required state fields.
          selector: (state) => (state.loadingStatus, state.error),
          builder: (context, state) {
            /// Create individual variables of the selected state using record destructuring.
            final (loadingStatus, error) = state;

            return DataLoadingContainer(
              onRefresh:
                  () => context.read<HistoryDetailsCubit>().load(_eventId),
              loadingStatus: loadingStatus,
              successContent: _buildSuccessLayout,
              errorMessage: error,
            );
          },
        ),
      ),
    );
  }

  Widget _buildSuccessLayout(BuildContext context) {
    /// Guaranteed to have content at this point.
    final event =
        context.select((HistoryDetailsCubit cubit) => cubit.state.content)!;

    final String formattedDate = formatDateTime(
      DateTime.parse(event.eventDateUtc),
    );

    return MinHeightScrollableBody(
      centreChild: false,
      child: Padding(
        padding: kGuttersAllLg,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: kSpaceSm,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(event.title, style: TextTheme.of(context).titleLarge),
                Text(formattedDate, style: TextTheme.of(context).labelMedium),
              ],
            ),
            if (event.flightNumber != null)
              AppTextButton(
                text: context.localizations.flightNumberText(
                  event.flightNumber!,
                ),
                onPressed: () {
                  context.read<HistoryDetailsCubit>().navigateToEventDetails(
                    event.flightNumber!,
                  );
                },
              ),

            Text(event.details, style: TextTheme.of(context).bodyLarge),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildLinks(event.links),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildLinks(EventLinks eventLinks) {
    List<Widget> links = [];

    for (var link in eventLinks.toJson().entries) {
      if (link.value != null) {
        links.add(AppLinkButton(text: link.key, urlString: link.value));
      }
    }
    return links;
  }
}
