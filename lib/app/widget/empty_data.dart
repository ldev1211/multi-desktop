import 'package:flutter/material.dart';

class ViewEmptyData extends StatelessWidget {
  ViewEmptyData({
    super.key,
    this.text = "Không có dữ liệu",
    this.textStyle,
  });

  String text;
  TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: textStyle ??
              const TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
        )
      ],
    );
  }
}
