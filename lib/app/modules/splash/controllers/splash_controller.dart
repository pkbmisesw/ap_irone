import 'package:silahan_kawan/app/modules/auth/auth_screen.dart';
import 'package:silahan_kawan/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:silahan_kawan/main.dart';
import 'package:logger/logger.dart';
import 'package:silahan_kawan/app/shared/values.dart';

import '../../init/controllers/init_controller.dart';

class SplashController extends GetxController {
  late final InitController initC;
  final logger = Logger();

  @override
  void onInit() {
    super.onInit();

    if (Get.isRegistered<InitController>()) {
      initC = Get.find<InitController>();
    }
  }

  Future<void> checkIsUserHasLogin() async {
    final String? tokenDB = await initC.storage.read(key: extraAuthToken);
    final int levelDB =
        int.parse(await initC.storage.read(key: extraAuthLevel) ?? '0');

    if (loginStatus) {
      moveToPage(Routes.MAIN_USER);

      // switch (levelDB) {
      //   case levelSuperAdmin:
      //     moveToPage(Routes.MAIN_SUPER_ADMIN);
      //   case levelAdmin:
      //     moveToPage(Routes.MAIN_ADMIN);
      //   case levelUser:
      //     moveToPage(Routes.MAIN_USER);
      //   case levelAdminKecamatan:
      //     moveToPage(Routes.MAIN_ADMIN_KEC);
      // }

      // if (token == tokenDB) {
      // }
    } else {
      Get.to(() => AuthView());
    }
  }

  @override
  void onReady() {
    super.onReady();
    checkIsUserHasLogin();
  }

  void moveToPage(String routeName) => Future.delayed(
        const Duration(seconds: 3),
        () => Get.offAllNamed(routeName),
      );
}
