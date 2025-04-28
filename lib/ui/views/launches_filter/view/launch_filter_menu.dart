import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_x/i18n/i18n.dart';
import 'package:flutter_space_x/ui/ui_helpers.dart';
import 'package:flutter_space_x/ui/views/launches_list/state/launches_list_cubit.dart';
import 'package:flutter_space_x/ui/widgets/forms/launch_site_dropdown_selector.dart';
import 'package:flutter_space_x/ui/widgets/forms/rocket_dropdown_selector.dart';
import 'package:flutter_space_x/ui/widgets/forms/year_dropdown_selector.dart';

class LaunchFilterMenu extends StatelessWidget {
  const LaunchFilterMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Column(
          children: [
            Container(
              constraints: BoxConstraints(minHeight: kToolbarHeight),
              padding: EdgeInsets.fromLTRB(kSpaceLg, 0.0, kSpaceXs, 0.0),
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: ColorScheme.of(context).onSurfaceVariant,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    context.localizations.filterMenuHeading,
                    style: TextTheme.of(context).headlineMedium,
                  ),
                  IconButton(
                    icon: const Icon(Icons.close, size: 36),
                    onPressed: () {
                      Scaffold.of(context).closeEndDrawer();
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: Form(
                child: Padding(
                  padding: kGuttersSideLg,
                  child: ListView(
                    padding: kGuttersTopBottomLg,
                    children: [
                      BlocSelector<LaunchesListCubit, LaunchesListState, int?>(
                        selector: (state) => state.yearFilter,
                        builder: (context, selectedYear) {
                          return YearDropdownSelector(
                            selectedYear: selectedYear,
                            onChanged: (int? value) {
                              context.read<LaunchesListCubit>().onYearChanged(
                                value,
                              );
                            },
                          );
                        },
                      ),
                      kVerticalSpaceXl,
                      BlocSelector<
                        LaunchesListCubit,
                        LaunchesListState,
                        String?
                      >(
                        selector: (state) => state.rocketIdFilter,
                        builder: (context, selectedRocketId) {
                          return RocketDropdownSelector(
                            selectedRocketId: selectedRocketId,
                            onChanged: (String? value) {
                              context
                                  .read<LaunchesListCubit>()
                                  .onRocketSelected(value);
                            },
                          );
                        },
                      ),
                      kVerticalSpaceXl,
                      BlocSelector<
                        LaunchesListCubit,
                        LaunchesListState,
                        String?
                      >(
                        selector: (state) => state.launchSiteIdFilter,
                        builder: (context, selectedSiteId) {
                          return LaunchSiteDropdownSelector(
                            selectedLaunchSiteId: selectedSiteId,
                            onChanged: (String? value) {
                              context
                                  .read<LaunchesListCubit>()
                                  .onLaunchSiteSelected(value);
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(minHeight: kToolbarHeight),
              padding: kGuttersAllLg,
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: ColorScheme.of(context).onSurfaceVariant,
                  ),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                spacing: kSpaceLg,
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        context.read<LaunchesListCubit>().resetFilters();
                        // Close drawer after selection.
                        Scaffold.of(context).closeEndDrawer();
                      },
                      child: Text(context.localizations.resetButtonText),
                    ),
                  ),
                  Expanded(
                    child: FilledButton(
                      onPressed: () {
                        context.read<LaunchesListCubit>().load();
                        // Close drawer after selection.
                        Scaffold.of(context).closeEndDrawer();
                      },
                      child: Text(context.localizations.searchButtonText),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
