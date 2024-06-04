import 'dart:convert';

import 'package:silahan_kawan/app/data/models/auth/login/login_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalDb {
  static const String keyCredential = "credential";
  static const String keyLoginToken = "token_login";
  static const String keyTokenDevice = "token_device";
  static const String keyDeviceHW = "device_hw";
  static const String keyRecentGPS = "recent_gps";
  static const String keyRepeat = "repeat";
  static const String keyLoggedIn = "logged_in";

  static late SharedPreferences _prefs;

  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  static set credential(LoginModel data) =>
      _prefs.setString(keyCredential, jsonEncode(data.toJson()));

  static LoginModel get credential =>
      LoginModel.fromJson(jsonDecode(_prefs.getString(keyCredential)!));

  static Future<void> logout() async {
    await Future.wait([
      _prefs.remove(keyCredential),
    ]);
  }
}
// PENGEN DI AMBIL DI HALAMAN MENU UTAMA?
// ketika login maka masuk ke shared preferences , munculkan dia data id_kel di menu Data Umum,, Data Umum itu ada disini