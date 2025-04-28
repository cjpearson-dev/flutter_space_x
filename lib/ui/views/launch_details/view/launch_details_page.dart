import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_x/i18n/i18n.dart';
import 'package:flutter_space_x/models/launch.dart';
import 'package:flutter_space_x/repositories/data_loading_status.dart';
import 'package:flutter_space_x/ui/ui_helpers.dart';
import 'package:flutter_space_x/ui/widgets/widgets.dart';
import 'package:flutter_space_x/utils/date_format.dart';

import '../state/launch_details_cubit.dart';

@RoutePage()
class LaunchDetailsPage extends StatelessWidget {
  final int _flightNumber;

  const LaunchDetailsPage(this._flightNumber, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.localizations.launchDetailsTitle)),
      body: BlocProvider(
        /// Create cubit and immediately fetch data.
        create: (_) => LaunchDetailsCubit()..load(_flightNumber),
        child: BlocSelector<
          LaunchDetailsCubit,
          LaunchDetailsState,
          (DataLoadingStatus, String?)
        >(
          /// Create a record of the required state fields.
          selector: (state) => (state.loadingStatus, state.error),
          builder: (context, state) {
            /// Create individual variables of the selected state using record destructuring.
            final (loadingStatus, error) = state;

            return DataLoadingContainer(
              onRefresh:
                  () => context.read<LaunchDetailsCubit>().load(_flightNumber),
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
    final launch =
        context.select((LaunchDetailsCubit cubit) => cubit.state.content)!;

    final String formattedDate = formatDateTime(
      DateTime.parse(launch.launchDateUtc),
    );

    final images = launch.links.flickrImages;
    final imageSize = 250.0;

    return MinHeightScrollableBody(
      centreChild: false,
      child: Column(
        children: [
          if (images.isNotEmpty)
            SizedBox(
              height: imageSize,
              child: CarouselView(
                shape: ContinuousRectangleBorder(),
                scrollDirection: Axis.horizontal,
                itemExtent: imageSize,
                children:
                    images
                        .map((img) => AppNetworkImage(img, fit: BoxFit.cover))
                        .toList(),
              ),
            ),
          Padding(
            padding: kGuttersAllLg,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: kSpaceSm,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            launch.missionName,
                            style: TextTheme.of(context).titleLarge,
                          ),
                          Text(
                            formattedDate,
                            style: TextTheme.of(context).labelMedium,
                          ),
                        ],
                      ),
                    ),
                    if (launch.launchSuccess != null)
                      LaunchStatusNote(wasSuccess: launch.launchSuccess!),
                  ],
                ),
                Text(context.localizations.flightNumberText(_flightNumber)),
                Text(
                  context.localizations.rocketNameText(
                    launch.rocket.rocketName,
                  ),
                  style: TextTheme.of(context).bodyLarge,
                ),
                Text(
                  context.localizations.launchSiteNameText(
                    launch.launchSite.siteNameLong,
                  ),
                  style: TextTheme.of(context).bodyLarge,
                ),
                if (launch.details != null)
                  Padding(
                    padding: const EdgeInsets.only(top: kSpaceLg),
                    child: Text(
                      launch.details!,
                      style: TextTheme.of(context).bodyLarge,
                    ),
                  ),
                _buildLinkList(launch.links),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLinkList(LaunchLinks links) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (links.articleLink != null)
          AppLinkButton(text: 'Article', urlString: links.articleLink!),
        if (links.redditLaunch != null)
          AppLinkButton(text: 'Reddit', urlString: links.redditLaunch!),
        if (links.wikipedia != null)
          AppLinkButton(text: 'Wikipedia', urlString: links.wikipedia!),
        if (links.videoLink != null)
          AppLinkButton(text: 'Youtube', urlString: links.videoLink!),
      ],
    );
  }
}
