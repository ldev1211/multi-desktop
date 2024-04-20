import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:multi_desktop/app/widget/app_progress.dart';

class AppCircleAvt extends StatelessWidget {
  AppCircleAvt({
    super.key,
    required this.url,
    this.width,
    this.height,
  });

  double? width;

  double? height;
  String url;

  @override
  Widget build(BuildContext context) {
    return ClipOval(
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        width: width,
        height: height,
        placeholder: (context, url) => const AppProgress(),
        errorWidget: (context, url, error) => Container(
          decoration: const BoxDecoration(color: Colors.grey),
          child: const Icon(Icons.person, color: Colors.white),
        ),
      ),
    );
  }
}
