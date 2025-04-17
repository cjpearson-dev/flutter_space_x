import 'package:flutter/material.dart';

import 'min_height_scrollable_body.dart';

class ScreenErrorMessage extends StatelessWidget {
  final String message;

  const ScreenErrorMessage(this.message, {super.key});

  @override
  Widget build(BuildContext context) {
    return MinHeightScrollableBody(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          const Icon(Icons.error_outline_outlined, size: 50),
          Text(message),
        ],
      ),
    );
  }
}
