import 'package:irone/app/modules/init/controllers/init_controller.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:irone/app/services/auth_services.dart';
import 'package:irone/app/shared/shared_method.dart';

class RegisterController extends GetxController {
  late final InitController initC;
  late final AuthServices _authService;
  late final GlobalKey<FormState> formKey;
  late final TextEditingController namaC;
  late final TextEditingController emailC;
  late final TextEditingController passwordC;

  final nama = ''.obs;
  final email = ''.obs;
  final oldPassword = ''.obs;
  final newPassword = ''.obs;

  final isLoading = false.obs;
  final isObscure = true.obs;

  String get appName => initC.packageInfo.appName;

  @override
  void onInit() {
    super.onInit();

    if (Get.isRegistered<InitController>()) {
      initC = Get.find<InitController>();
    }

    _authService = AuthServices();
    formKey = GlobalKey<FormState>();
    namaC = TextEditingController();
    emailC = TextEditingController();
    passwordC = TextEditingController();

    namaC.addListener(() => setNama());
    emailC.addListener(() => setEmail());
  }

  void setNama() => nama.value = namaC.text;

  void setEmail() => email.value = emailC.text;

  void setLoading(bool state) => isLoading.value = state;

  void setObscure() => isObscure.toggle();

  String? validatorNama(value) {
    if (value!.isEmpty) {
      return 'Nama tidak boleh kosong';
    }
    return null;
  }

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

  Future<void> checkRegisterData(ThemeData theme) async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) {
      return;
    }

    formKey.currentState!.save();

    final nama = namaC.value.text.trim();
    final email = emailC.value.text.trim();
    final password = passwordC.value.text;

    if (nama.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      FocusScope.of(Get.context!).unfocus();
      setLoading(true);

      final map = {
        'nama': nama,
        'email': email,
        'password': password,
      };

      try {
        final res = await _authService.register(map);
        final success = res.success;

        setLoading(false);

        if (success != null) {
          showSnackbar(
            message: 'Berhasil Mendaftarkan Akun!',
            bgColor: Colors.green,
            textColor: Colors.white,
          );

          moveToLogin();
        } else {
          showSnackbar(
            message: 'Gagal registrasi!',
            bgColor: theme.colorScheme.errorContainer,
            textColor: theme.colorScheme.onSurface,
          );
        }
      } on DioException catch (e) {
        Logger().e('Error: $e');

        if (e.type == DioExceptionType.badResponse) {
          showSnackbar(
            message: 'Periksa kembali kolom pengisian dan coba lagi!',
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

  void moveToLogin() => Get.back();

  @override
  void onClose() {
    namaC.dispose();
    emailC.dispose();
    passwordC.dispose();
    super.onClose();
  }
}
