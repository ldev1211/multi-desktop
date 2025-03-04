import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:multi_desktop/app/features/login/data/enitity/student_entity.dart';
import 'package:multi_desktop/app/features/members/presentation/members_page.dart';
import 'package:multi_desktop/app/widget/app_button.dart';
import 'package:multi_desktop/main.dart';
import 'package:multi_desktop/network/route/apiservice.dart';
import 'package:multi_desktop/util/app_colors.dart';
import 'package:multi_desktop/util/pref/pref_utils.dart';
import 'package:multi_desktop/util/ui_util.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  var isShowProgressBar = false;
  final _textStuCodeController = TextEditingController();
  final _textPasswordController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool isHidePass = true;

  bool isFocusPass = false;
  bool isFocusUsername = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: Stack(
      children: [
        Image.asset(
          "assets/image/login_bgr.png",
          width: size.width,
          height: size.height,
          fit: BoxFit.cover,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: size.width * 0.45,
              margin: const EdgeInsets.only(left: 24),
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: AppColor.colorMain, width: 3),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Mã số sinh viên",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 45,
                    padding: const EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(
                        color:
                            isFocusUsername ? AppColor.colorMain : Colors.grey,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      onTap: () {
                        setState(() {
                          isFocusPass = false;
                          isFocusUsername = true;
                        });
                      },
                      onTapOutside: (e) {
                        setState(() {
                          isFocusPass = false;
                          isFocusUsername = false;
                        });
                      },
                      textAlignVertical: TextAlignVertical.center,
                      cursorColor: AppColor.colorMain,
                      controller: _textStuCodeController,
                      decoration: const InputDecoration.collapsed(
                        hintText: "Ví dụ: N20DCPTxxx",
                        hintStyle: TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Text(
                    "Mật khẩu",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    height: 45,
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      border: Border.all(
                          color:
                              isFocusPass ? AppColor.colorMain : Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: TextField(
                      onTap: () {
                        setState(() {
                          isFocusUsername = false;
                          isFocusPass = true;
                        });
                      },
                      onTapOutside: (e) {
                        setState(() {
                          isFocusUsername = false;
                          isFocusPass = false;
                        });
                      },
                      textAlignVertical: TextAlignVertical.center,
                      obscureText: isHidePass,
                      cursorColor: AppColor.colorMain,
                      controller: _textPasswordController,
                      decoration: InputDecoration(
                        suffixIcon: GestureDetector(
                          onTap: () {
                            setState(() {
                              isHidePass = !isHidePass;
                            });
                          },
                          child: (isHidePass)
                              ? Icon(
                                  Icons.remove_red_eye_outlined,
                                  size: 28,
                                  color: isFocusPass
                                      ? AppColor.colorMain
                                      : Colors.black,
                                )
                              : SvgPicture.asset(
                                  'assets/svg/invisible.svg',
                                  color: isFocusPass
                                      ? AppColor.colorMain
                                      : Colors.black,
                                  fit: BoxFit.scaleDown,
                                  width: 12,
                                  height: 12,
                                ),
                        ),
                        hintText: "Mật khẩu",
                        border: InputBorder.none,
                        hintStyle: const TextStyle(
                          color: Colors.grey,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  AppButton.buttonPrimary(
                    height: 45,
                    text: 'Đăng nhập',
                    onTap: () async {
                      if (_textStuCodeController.text.isEmpty ||
                          _textPasswordController.text.isEmpty) {
                        UIUtil.showToast("Vui lòng nhập đầy đủ thông tin");
                        return;
                      }
                      UIUtil.showDialogLoading(context);
                      Map<String, String> body = {
                        "mssv": _textStuCodeController.text,
                        "password": _textPasswordController.text
                      };
                      final response = await service.login(body);
                      print(response);
                      if (!response.error) {
                        PrefUtil.instance
                            .setString("accessToken", response.accessToken!);
                        StudentEntity student =
                            StudentEntity.fromJson(response.data);
                        PrefUtil.instance.setString("mssv", student.stuCode);
                        PrefUtil.instance.setInt("role", student.role ?? 6);
                        service = ApiService(dio.Dio(), baseUrl: url);
                        Navigator.pop(context);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const MembersPage()));
                      } else {
                        Navigator.pop(context);
                        UIUtil.showDialogMessage(
                          context: context,
                          message: response.message,
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    ));
  }
}
