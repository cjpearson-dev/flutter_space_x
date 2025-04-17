import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_space_x/features/filters/launches/launch_filters_cubit.dart';

import 'forms/year_dropdown_selector.dart';

class SortFilterMenu extends StatelessWidget {
  const SortFilterMenu({super.key});

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
                  Text('Filter', style: TextTheme.of(context).headlineMedium),
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
                      BlocSelector<
                        LaunchFiltersCubit,
                        LaunchFiltersState,
                        int?
                      >(
                        selector: (state) => state.selectedYear,
                        builder: (context, selectedYear) {
                          return YearDropdownSelector(
                            selectedYear: selectedYear,
                            onChanged: (int? value) {
                              context.read<LaunchFiltersCubit>().onYearChanged(
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
          ],
        ),
      ),
    );
  }
}
