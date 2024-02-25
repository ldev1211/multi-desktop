import 'package:shared_preferences/shared_preferences.dart';

class PrefUtil {
  static SharedPreferences? _instance;
  static SharedPreferences get instance => _instance!;

  static Future<void> init() async {
    _instance = await SharedPreferences.getInstance();
  }
}
