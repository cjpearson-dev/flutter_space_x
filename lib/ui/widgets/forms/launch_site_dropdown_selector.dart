import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_x/i18n/i18n.dart';

import '../../../models/launch.dart';
import '../../views/launches_filter/state/launches_filter_cubit.dart';

class LaunchSiteDropdownSelector extends StatelessWidget {
  final String? selectedLaunchSiteId;

  final ValueChanged<String?> onChanged;

  const LaunchSiteDropdownSelector({
    super.key,
    required this.selectedLaunchSiteId,
    required this.onChanged,
    String? selectedRocketId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      LaunchesFilterCubit,
      LaunchesFilterState,
      List<LaunchSiteDetail>
    >(
      selector: (state) => state.launchPads!,
      builder: (context, launchPads) {
        return DropdownButtonFormField<String>(
          value: selectedLaunchSiteId,
          decoration: InputDecoration(
            labelText: context.localizations.launchPadSelectorLabel,
            border: OutlineInputBorder(),
          ),
          items:
              launchPads.map((launchPad) {
                return DropdownMenuItem<String>(
                  value: launchPad.siteId,
                  child: Text(launchPad.name),
                );
              }).toList(),
          onChanged: onChanged,
        );
      },
    );
  }
}
