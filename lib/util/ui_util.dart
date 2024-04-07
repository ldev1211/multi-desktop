import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:multi_desktop/app/widget/app_button.dart';
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

  static Future<bool?> showDialogInputFile(
    BuildContext context, {
    required List<TextEditingController> controllers,
  }) async {
    Size size = MediaQuery.of(context).size;
    double space = 21;
    return await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            height: size.height * 0.8,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(200)),
            padding: const EdgeInsets.all(12),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: size.width * 0.4,
                      height: 45,
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: AppColor.colorMain,
                        controller: controllers[0],
                        decoration: const InputDecoration.collapsed(
                          hintText: "Chủ trì cuộc họp",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      alignment: Alignment.center,
                      width: size.width * 0.2,
                      height: 45,
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: AppColor.colorMain,
                        controller: controllers[1],
                        decoration: const InputDecoration.collapsed(
                          hintText: "Chức vụ",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: space),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: size.width * 0.4,
                      height: 45,
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: AppColor.colorMain,
                        controller: controllers[2],
                        decoration: const InputDecoration.collapsed(
                          hintText: "Thư ký cuộc họp",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      alignment: Alignment.center,
                      width: size.width * 0.2,
                      height: 45,
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: AppColor.colorMain,
                        controller: controllers[3],
                        decoration: const InputDecoration.collapsed(
                          hintText: "Chức vụ",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: space),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: size.width * 0.2,
                      height: 45,
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: AppColor.colorMain,
                        controller: controllers[4],
                        decoration: const InputDecoration.collapsed(
                          hintText: "Thời gian bắt đầu",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      alignment: Alignment.center,
                      width: size.width * 0.2,
                      height: 45,
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: AppColor.colorMain,
                        controller: controllers[5],
                        decoration: const InputDecoration.collapsed(
                          hintText: "Thời gian kết thúc",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: space),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: size.width * 0.2,
                      height: 45,
                      padding: const EdgeInsets.symmetric(
                        vertical: 4,
                        horizontal: 8,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        border: Border.all(
                          color: Colors.grey,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        textAlignVertical: TextAlignVertical.center,
                        cursorColor: AppColor.colorMain,
                        controller: controllers[6],
                        decoration: const InputDecoration.collapsed(
                          hintText: "Địa điểm",
                          hintStyle: TextStyle(
                            color: Colors.grey,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AppButton.buttonSecondary(
                      width: size.width * 0.2,
                      height: 45,
                      text: "Huỷ",
                      onTap: () {
                        Navigator.pop(context);
                        return false;
                      },
                    ),
                    AppButton.buttonPrimary(
                      width: size.width * 0.3,
                      height: 45,
                      text: "OK",
                      onTap: () {
                        Navigator.pop(context);
                        return true;
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        );
      },
    );
  }

  static void showDialogImage(
      {required BuildContext context, required String url}) {
    Size size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            height: size.height * 0.8,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(200)),
            ),
            padding: const EdgeInsets.all(12),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.network(
                  url,
                  height: size.height * 0.7,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  static void showDialogMessage({
    required BuildContext context,
    required String message,
    Function? onOk,
    Function? onCancel,
  }) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content: Container(
            height: 200,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(200)),
            ),
            padding: const EdgeInsets.all(24),
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Tin nhắn",
                  style: TextStyle(color: AppColor.colorMain, fontSize: 24),
                ),
                const SizedBox(height: 24),
                Text(
                  message,
                  style: const TextStyle(color: Colors.black, fontSize: 18),
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        if (onOk != null) onOk();
                      },
                      child: const Text(
                        "Đồng ý",
                        style: TextStyle(color: AppColor.colorMain),
                      ),
                    ),
                    const SizedBox(width: 42),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Huỷ",
                        style: TextStyle(color: AppColor.colorMain),
                      ),
                    ),
                  ],
                )
              ],
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
