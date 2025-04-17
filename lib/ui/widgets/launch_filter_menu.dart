import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_x/i18n/i18n.dart';

import '../views/launches_list/state/launches_list_cubit.dart';
import 'forms/year_dropdown_selector.dart';

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
              padding: EdgeInsets.fromLTRB(18.0, 0, 2.0, 0.0),
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
                  padding: const EdgeInsets.symmetric(horizontal: 18.0),
                  child: ListView(
                    padding: const EdgeInsets.symmetric(vertical: 18.0),
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
                    ],
                  ),
                ),
              ),
            ),
            Container(
              constraints: BoxConstraints(minHeight: kToolbarHeight),
              padding: EdgeInsets.all(18.0),
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
                spacing: 16.0,
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
