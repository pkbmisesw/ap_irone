import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class InitController extends GetxController {
  late final PackageInfo _packageInfo;

  late final AndroidOptions _getAndroidOptions;
  late final IOSOptions _getIOSOptions;
  late final FlutterSecureStorage _storage;

  PackageInfo get packageInfo => _packageInfo;

  FlutterSecureStorage get storage => _storage;

  @override
  void onInit() {
    super.onInit();

    _initPackageInfo();

    _getAndroidOptions = const AndroidOptions(encryptedSharedPreferences: true);
    _getIOSOptions =
        const IOSOptions(accessibility: KeychainAccessibility.first_unlock);

    if (GetPlatform.isIOS) {
      _storage = FlutterSecureStorage(iOptions: _getIOSOptions);
    } else if (GetPlatform.isAndroid) {
      _storage = FlutterSecureStorage(aOptions: _getAndroidOptions);
    } else {
      _storage = const FlutterSecureStorage();
    }

    checkThemeMode();
  }

  Future<void> _initPackageInfo() async =>
      _packageInfo = await PackageInfo.fromPlatform();

  void checkThemeMode() => storage.read(key: 'isDarkMode').then((value) {
        if (value != null) {
          Get.changeThemeMode(
            value == 'true' ? ThemeMode.dark : ThemeMode.light,
          );
        }
      });
}
