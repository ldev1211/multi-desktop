import 'package:flutter/material.dart';
import 'package:multi_desktop/util/app_colors.dart';

class AppButton {
  static Widget buttonPrimary({
    double? width,
    double? height,
    required String text,
    Function? onTap,
  }) =>
      InkWell(
        onTap: () {
          if (onTap != null) onTap();
        },
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: AppColor.colorMain,
              border: Border.all(color: AppColor.colorMain),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 4),
                  blurRadius: 8,
                )
              ]),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
            ),
          ),
        ),
      );

  static Widget buttonSecondary({
    required double width,
    required double height,
    required String text,
    Function? onTap,
  }) =>
      InkWell(
        onTap: () {
          if (onTap != null) onTap();
        },
        child: Container(
          width: width,
          height: height,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: AppColor.colorMain),
              borderRadius: BorderRadius.circular(12),
              boxShadow: const [
                BoxShadow(
                  color: Colors.grey,
                  offset: Offset(0, 4),
                  blurRadius: 8,
                )
              ]),
          child: Text(
            text,
            style: const TextStyle(
              color: AppColor.colorMain,
            ),
          ),
        ),
      );
}
