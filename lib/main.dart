import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:multi_desktop/app/features/login/presentation/login_page.dart';
import 'package:multi_desktop/app/features/members/presentation/members_page.dart';
import 'package:multi_desktop/network/route/apiservice.dart';
import 'package:multi_desktop/util/pref/pref_utils.dart';

late ApiService service;
const String url = 'http://localhost:3000/delegation_chief_role';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefUtil.init();
  service = ApiService(dio.Dio(), baseUrl: url);
  bool isLoggedIn = PrefUtil.instance.getString("accessToken") != null;
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: (isLoggedIn) ? const MembersPage() : const LoginPage(),
    ),
  );
}
