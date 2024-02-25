import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_desktop/util/app_colors.dart';

class UIUtil {
  static void showDialogLoading(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            height: 50,
            decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(200))),
            alignment: Alignment.center,
            child: const CircularProgressIndicator(
              color: AppColor.colorMain,
              strokeWidth: 5,
            ),
          ),
        );
      },
    );
  }

  static void showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        fontSize: 14.0);
  }
}
