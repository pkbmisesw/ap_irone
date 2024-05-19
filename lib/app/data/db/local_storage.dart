import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static String idKec = "idKec";
  static String idKel = "idKel";

  static Future<String> getIdKec() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idkec = prefs.getString(LocalStorage.idKec);
    return idkec!;
  }

  static saveIdKec(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LocalStorage.idKec, value);
  }

  static Future<String> getIdKel() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? idkel = prefs.getString(LocalStorage.idKel);
    return idkel!;
  }

  static saveIdKel(String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(LocalStorage.idKel, value);
  }
}
