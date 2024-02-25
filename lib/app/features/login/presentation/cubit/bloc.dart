import 'package:bloc/bloc.dart';
import 'package:build_flutter/main.dart';
import 'package:build_flutter/util/pref/pref_utils.dart';

import 'event.dart';
import 'state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc() : super(InitState()) {
    on<InitEvent>(_init);
    on<SignInEvent>(signIn);
  }

  void _init(InitEvent event, Emitter<LoginState> emit) async {}
  void signIn(SignInEvent event, Emitter<LoginState> emit) async {
    final Map<String, dynamic> bodyMap = {
      "mssv": event.mssv,
      "password": event.password
    };
    final response = await service.login(bodyMap);
    if (!response.error) {
      PrefUtil.instance.setString("accessToken", response.accessToken!);
      PrefUtil.instance
          .setString("stuCodeCurr", response.studentEntity!.stuCode);
      PrefUtil.instance
          .setString("stuNameCurr", response.studentEntity!.fullName);
      PrefUtil.instance.setString("linkAvtCurr", response.studentEntity!.avt);
      PrefUtil.instance
          .setString("phoneCurr", response.studentEntity!.phoneNumber);
      PrefUtil.instance.setString("fbCurr", response.studentEntity!.linkFb);
      PrefUtil.instance
          .setString("persEmailCurr", response.studentEntity!.personalEmail);
      PrefUtil.instance
          .setInt("isHidePhone", response.studentEntity!.isHidePhone);
      PrefUtil.instance
          .setInt("isHideEmail", response.studentEntity!.isHideEmail);
      PrefUtil.instance.setInt("isHideFb", response.studentEntity!.isHideFb);
      PrefUtil.instance.setInt("isCtv", response.studentEntity!.ctv);
      PrefUtil.instance.setInt("isBCH", response.studentEntity!.bch);
      PrefUtil.instance.setInt("isBCS", response.studentEntity!.bcs);
      PrefUtil.instance.setBool("isNotifiSchedule", true);
      PrefUtil.instance.setBool("isNotifiUpdPoint", true);
      PrefUtil.instance.setBool("isNotifiEvent", true);
      PrefUtil.instance.setBool("isBubbleChat", true);
      PrefUtil.instance.setBool("isStateOnl", true);
    }
    emit(SignInState(!response.error, response.message));
  }
}
