import 'package:build_flutter/app/features/login/presentation/cubit/bloc.dart';
import 'package:build_flutter/app/features/login/presentation/cubit/event.dart';
import 'package:build_flutter/app/features/login/presentation/cubit/state.dart';
import 'package:build_flutter/main.dart';
import 'package:build_flutter/util/app_colors.dart';
import 'package:build_flutter/util/ui_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  var isShowProgressBar = false;
  final _textStuCodeController = TextEditingController();
  final _textPasswordController = TextEditingController();

  late LoginBloc loginBloc;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loginBloc = LoginBloc()..add(InitEvent());
  }

  bool isHidePass = true;

  bool isFocusPass = false;
  bool isFocusUsername = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => loginBloc,
      child: BlocListener<LoginBloc, LoginState>(
        listenWhen: (prev, curr) {
          return curr is SignInState;
        },
        listener: (context, state) {
          if (state is SignInState) {
            Navigator.pop(context);
            if (state.isSuccess) {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => MainPage(
                          path: '',
                        )),
              );
            } else {
              UIUtil.showToast(state.message);
            }
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset("images/ic_circle_multi.svg",
                width: 80, height: 80),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 4,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [
                      AppColor.colorMain,
                      Colors.white,
                    ],
                  )),
                ),
                const Padding(padding: EdgeInsets.only(right: 12)),
                const Text(
                  "Đăng nhập",
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22),
                ),
                const Padding(padding: EdgeInsets.only(right: 12)),
                Container(
                  width: MediaQuery.of(context).size.width * 0.25,
                  height: 4,
                  decoration: const BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    colors: [Colors.white, AppColor.colorMain],
                  )),
                )
              ],
            ),
            Padding(
                padding: const EdgeInsets.only(top: 24, left: 24, right: 24),
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
                            color: isFocusUsername
                                ? AppColor.colorMain
                                : Colors.grey),
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
                        vertical: 4,
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
                    Container(
                      height: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.shade400,
                              offset: const Offset(0, 4),
                              blurRadius: 12,
                            )
                          ],
                          color: AppColor.colorMain,
                          border: Border.all(color: Colors.orange),
                          borderRadius: BorderRadius.circular(12)),
                      child: InkWell(
                        onTap: () async {
                          if (_textStuCodeController.text.isEmpty ||
                              _textPasswordController.text.isEmpty) {
                            UIUtil.showToast("Vui lòng nhập đầy đủ thông tin");
                            return;
                          }
                          UIUtil.showDialogLoading(context);
                          loginBloc.add(SignInEvent(_textStuCodeController.text,
                              _textPasswordController.text));
                        },
                        child: Material(
                          borderRadius: BorderRadius.circular(12),
                          color: AppColor.colorMain,
                          child: const Text(
                            "Đăng nhập",
                            style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ],
        ),
      ),
    ));
  }
}
