import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

// Wrapper around [CachedNetworkImage]
class AppNetworkImage extends StatelessWidget {
  final String imageUrl;

  final BoxFit? fit;

  const AppNetworkImage(this.imageUrl, {super.key, this.fit});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: fit ?? BoxFit.contain,
      placeholder:
          (context, url) => const Center(child: CircularProgressIndicator()),
      errorWidget:
          (context, url, error) => const Center(child: Icon(Icons.error)),
    );
  }
}
