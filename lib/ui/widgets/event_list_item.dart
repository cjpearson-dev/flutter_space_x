import 'package:flutter/material.dart';

class EventListItem extends StatelessWidget {
  final String title;
  final String text;
  final int? textMaxLines;
  final void Function()? onPress;

  const EventListItem({
    super.key,
    required this.title,
    required this.text,
    this.textMaxLines,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: ListTile(
        onTap: onPress,
        title: Text(title, style: TextTheme.of(context).titleMedium),
        subtitle: Text(
          text,
          maxLines: textMaxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ),
    );
  }
}
