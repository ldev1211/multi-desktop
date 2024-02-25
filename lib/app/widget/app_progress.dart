import 'package:flutter/material.dart';
import 'package:multi_desktop/util/app_colors.dart';

class AppProgress extends StatelessWidget {
  const AppProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      color: AppColor.colorMain,
    );
  }
}
