import 'package:flutter/material.dart';

import 'app_network_image.dart';
import 'launch_status_note.dart';

class LaunchListItem extends StatelessWidget {
  final String title;

  final String year;

  final String? imageUrl;

  final bool? wasSuccess;

  final void Function()? onPress;

  const LaunchListItem({
    super.key,
    required this.title,
    required this.year,
    this.imageUrl,
    this.wasSuccess,
    this.onPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              color: Colors.grey,
              child: AspectRatio(
                aspectRatio: 5 / 4,
                child:
                    imageUrl != null
                        ? AppNetworkImage(imageUrl!, fit: BoxFit.cover)
                        : Center(
                          child: Icon(Icons.image_not_supported_outlined),
                        ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      maxLines: 2,
                      style: TextTheme.of(
                        context,
                      ).titleMedium?.copyWith(fontWeight: FontWeight.bold),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(year, style: TextTheme.of(context).labelMedium),
                        if (wasSuccess != null)
                          LaunchStatusNote(wasSuccess: wasSuccess!),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
