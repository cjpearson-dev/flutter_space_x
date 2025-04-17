import 'package:flutter/material.dart';
import 'package:flutter_space_x/i18n/i18n.dart';

class YearDropdownSelector extends StatelessWidget {
  final int? selectedYear;

  final ValueChanged<int?> onChanged;

  const YearDropdownSelector({
    super.key,
    required this.selectedYear,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    // Get current year
    final currentYear = DateTime.now().year;

    // Generate list of years from 2006 to current year
    final years =
        List<int>.generate(
          currentYear - 2005,
          (index) => 2006 + index,
        ).reversed.toList(); // Show most recent years first

    return DropdownButtonFormField<int>(
      value: selectedYear,
      decoration: InputDecoration(
        labelText: context.localizations.yearSelectorLabel,
        border: OutlineInputBorder(),
      ),
      items:
          years.map((year) {
            return DropdownMenuItem<int>(
              value: year,
              child: Text(year.toString()),
            );
          }).toList(),
      onChanged: onChanged,
    );
  }
}
