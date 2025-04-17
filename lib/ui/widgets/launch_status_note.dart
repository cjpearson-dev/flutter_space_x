import 'package:flutter/material.dart';
import 'package:flutter_space_x/i18n/i18n.dart';

class LaunchStatusNote extends StatelessWidget {
  final bool wasSuccess;

  const LaunchStatusNote({super.key, required this.wasSuccess});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 6),
      decoration: ShapeDecoration(
        shape: StadiumBorder(),
        color:
            wasSuccess
                ? Colors.green.shade800
                : ColorScheme.of(context).errorContainer,
      ),
      child: Text(
        wasSuccess
            ? context.localizations.successLabel
            : context.localizations.failureLabel,
        style: TextTheme.of(
          context,
        ).labelMedium?.copyWith(color: ColorScheme.of(context).onSurface),
      ),
    );
  }
}
