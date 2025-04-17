import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_x/i18n/i18n.dart';
import 'package:flutter_space_x/repositories/data_loading_status.dart';
import 'package:flutter_space_x/ui/widgets/widgets.dart';

import '../state/launches_list_cubit.dart';

// Would ideally with more time replace these annotations with my own to decouple these views completely from auto_route.
@RoutePage()
class LaunchesListPage extends StatefulWidget {
  const LaunchesListPage({super.key});

  @override
  State<LaunchesListPage> createState() => _LaunchesListPageState();
}

class _LaunchesListPageState extends State<LaunchesListPage> {
  // Made this stateful purely for access to the initState method to trigger data fetch.
  @override
  void initState() {
    super.initState();
    context.read<LaunchesListCubit>().load();
  }

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      LaunchesListCubit,
      LaunchesListState,
      (DataLoadingStatus, String?)
    >(
      /// Create a record of the required state fields.
      selector: (state) => (state.loadingStatus, state.error),
      builder: (context, state) {
        /// Create individual variables of the selected state using record destructuring.
        final (loadingStatus, error) = state;

        return DataLoadingContainer(
          onRefresh:
              () => context.read<LaunchesListCubit>().load(refresh: true),
          loadingStatus: loadingStatus,
          successContent: _buildSuccessLayout,
          errorMessage: error,
        );
      },
    );
  }

  Widget _buildSuccessLayout(BuildContext context) {
    /// Guaranteed to have content at this point.
    final launches =
        context.select((LaunchesListCubit cubit) => cubit.state.content)!;

    if (launches.isNotEmpty) {
      /// Show list of launches if fetched and not empty.
      return NotificationListener(
        onNotification: context.read<LaunchesListCubit>().onScrollNotification,
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            childAspectRatio: 0.73,
            crossAxisCount: 2,
            crossAxisSpacing: 6.0,
            mainAxisSpacing: 6.0,
          ),
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          itemCount: launches.length,
          itemBuilder: (BuildContext context, int index) {
            final launch = launches[index];

            return LaunchListItem(
              onPress: () {
                context.read<LaunchesListCubit>().navigateToEventDetails(
                  launch.flightNumber,
                );
              },
              title: launch.missionName,
              year: launch.launchYear,
              imageUrl: launch.links.flickrImages.firstOrNull,
              wasSuccess: launch.launchSuccess,
            );
          },
        ),
      );
    } else {
      /// Show message if data fetched successfully but no results present.
      return MinHeightScrollableBody(
        child: Text(context.localizations.noResultsMsg),
      );
    }
  }
}
