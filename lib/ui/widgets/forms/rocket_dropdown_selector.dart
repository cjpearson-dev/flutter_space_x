import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_x/i18n/i18n.dart';

import '../../../models/launch.dart';
import '../../views/launches_filter/state/launches_filter_cubit.dart';

class RocketDropdownSelector extends StatelessWidget {
  final String? selectedRocketId;

  final ValueChanged<String?> onChanged;

  const RocketDropdownSelector({
    super.key,
    required this.selectedRocketId,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return BlocSelector<
      LaunchesFilterCubit,
      LaunchesFilterState,
      List<LaunchRocket>
    >(
      selector: (state) => state.rockets!,
      builder: (context, rockets) {
        return DropdownButtonFormField<String>(
          value: selectedRocketId,
          decoration: InputDecoration(
            labelText: context.localizations.rocketSelectorLabel,
            border: OutlineInputBorder(),
          ),
          items:
              rockets.map((rocket) {
                return DropdownMenuItem<String>(
                  value: rocket.rocketId,
                  child: Text(rocket.rocketName),
                );
              }).toList(),
          onChanged: onChanged,
        );
      },
    );
  }
}
