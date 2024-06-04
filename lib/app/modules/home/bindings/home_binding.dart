import 'package:get/get.dart';

import 'package:silahan_kawan/app/modules/home/controllers/home_admin_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    //* HOME SUPER ADMIN CONTROLLER
    // Get.lazyPut<HomeSuperAdminController>(() => HomeSuperAdminController());

    //* HOME ADMIN CONTROLLER
    Get.lazyPut<HomeAdminController>(() => HomeAdminController());

    //* HOME USER CONTROLLER
    // Get.lazyPut<HomeUserController>(() => HomeUserController());
  }
}
