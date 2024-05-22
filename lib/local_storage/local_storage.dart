import 'dart:convert';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'user_model.dart';

class LocalStorageService {
  static const String _accessTokenKey = 'access_token';
  static const String _userDataKey = 'user_data';

  final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  Future<void> saveAccessToken(String accessToken) async {
    await _secureStorage.write(key: _accessTokenKey, value: accessToken);
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: _accessTokenKey);
  }

  Future<void> deleteAccessToken() async {
    await _secureStorage.delete(key: _accessTokenKey);
  }

  Future<void> saveUserData(UserData userData) async {
    String userDataJson = jsonEncode(userData);
    await _secureStorage.write(key: _userDataKey, value: userDataJson);
  }

  Future<UserData?> getUserData() async {
    String? userDataJson = await _secureStorage.read(key: _userDataKey);
    if (userDataJson != null) {
      return UserData.fromJson(json.decode(userDataJson));
    }
    return null;
  }

  Future<void> deleteUserData() async {
    await _secureStorage.delete(key: _userDataKey);
  }
}
