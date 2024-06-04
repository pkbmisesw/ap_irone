import 'package:silahan_kawan/app/data/models/auth/login/users_model.dart';
import 'package:silahan_kawan/app/modules/init/controllers/init_controller.dart';
import 'package:silahan_kawan/app/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silahan_kawan/local_storage/local_storage_helper.dart';
import 'package:logger/logger.dart';
import 'package:silahan_kawan/app/services/auth_services.dart';
import 'package:silahan_kawan/app/shared/shared_method.dart';
import 'package:silahan_kawan/app/shared/values.dart';
import 'package:silahan_kawan/app/utils/local_db.dart';

class LoginController extends GetxController {
  late final InitController initC;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailC;
  late final TextEditingController passwordC;
  late final AuthServices _authService;

  final RxBool isRemember = false.obs;
  final email = ''.obs;
  final isLoading = false.obs;
  final isObscure = true.obs;

  String get appName => initC.packageInfo.appName;

  @override
  void onInit() {
    super.onInit();

    if (Get.isRegistered<InitController>()) {
      initC = Get.find<InitController>();
    }

    formKey = GlobalKey<FormState>();
    emailC = TextEditingController();
    passwordC = TextEditingController();
    _authService = AuthServices();

    emailC.addListener(() => setEmail());
  }

  void setEmail() => email.value = emailC.text;

  void setLoading(bool state) => isLoading.value = state;

  void setObscure() => isObscure.toggle();

  String? validatorEmail(dynamic value) {
    if (value!.isEmpty) {
      return 'Email tidak boleh kosong';
    } else if (value is String && !value.isEmail) {
      return 'Email tidak valid';
    }
    return null;
  }

  String? validatorPassword(dynamic value) {
    if (value!.isEmpty) {
      return 'Password tidak boleh kosong';
    } else if (value.length < 6) {
      return 'Password minimal 6 karakter';
    }
    return null;
  }

  Future<void> checkIsUserExist(ThemeData theme) async {
    final isValid = formKey.currentState!.validate();
    if (isValid) {
      await SharedPreferenceHelper.setLogin(1);
      moveToPage(Routes.MAIN_USER);

      return;
    }

    formKey.currentState!.save();

    final email = emailC.value.text;
    final password = passwordC.value.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      FocusScope.of(Get.context!).unfocus();
      setLoading(true);

      final map = {
        'email': email,
        'password': password,
      };

      try {
        final resLoginModel = await _authService.login(map);
        final users = resLoginModel.users;

        setLoading(false);

        // && users.status == 1

        if (users != null) {
          final token = resLoginModel.token;
          final level = resLoginModel.users?.level;

          final map = <String, dynamic>{
            'token': token,
            'level': level,
            'users': users,
          };

          LocalDb.credential = resLoginModel;
          checkLevelUserLogin(map);
        } else {
          showSnackbar(
            message:
                'Status akun anda belum diaktifkan oleh admin!.\nHubungi admin untuk info lebih lanjut',
            duration: const Duration(hours: 1),
            action: SnackBarAction(
              label: 'Tutup',
              onPressed: () =>
                  ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar(),
            ),
          );
        }
      } on DioException catch (e) {
        Logger().e('Error: $e');

        if (e.type == DioExceptionType.badResponse) {
          showSnackbar(
            message: 'Email atau password yang anda masukkan salah!',
            bgColor: theme.colorScheme.errorContainer,
            textColor: theme.colorScheme.onSurface,
          );
        } else {
          showSnackbar(
            message: 'Periksa koneksi internet anda dan coba lagi!',
            bgColor: theme.colorScheme.errorContainer,
            textColor: theme.colorScheme.onSurface,
          );
        }

        setLoading(false);
      }
    }
  }

  Future<void> checkLevelUserLogin(Map map) async {
    final token = map['token'] as String?;
    final level = map['level'] as int?;
    final users = map['users'] as UsersModel?;

    if (token != null && level != null) {
      // write token and level
      await initC.storage.write(key: extraAuthToken, value: token);
      await initC.storage.write(key: extraAuthLevel, value: level.toString());

      switch (level) {
        case levelSuperAdmin:
          moveToPage(Routes.MAIN_SUPER_ADMIN);
        case levelAdmin:
          moveToPage(Routes.MAIN_ADMIN);
        case levelUser:
          moveToPage(Routes.MAIN_USER, users);
        case levelAdminKecamatan:
          moveToPage(Routes.MAIN_ADMIN_KEC);
      }
    }
  }

  void moveToPage(String routeName, [UsersModel? users]) => Get.offAllNamed(
        routeName,
        arguments: users,
      );

  void moveToRegister() => Get.toNamed(Routes.REGISTER);

  @override
  void onClose() {
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }
}
