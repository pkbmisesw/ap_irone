import 'package:silahan_kawan/app/modules/article/controllers/article_controller.dart';
import 'package:silahan_kawan/app/modules/home/controllers/home_super_admin_controller.dart';
import 'package:get/get.dart';

import 'package:silahan_kawan/app/modules/main/controllers/main_super_admin_controller.dart';

import '../../home/controllers/home_admin_kecamatan_controller.dart';
import '../../home/controllers/home_user_controller.dart';
import '../controllers/main_user_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    //* MAIN ADMIN CONTROLLER
    Get.lazyPut<MainAdminController>(() => MainAdminController());

    //* MAIN USER CONTROLLER
    Get.lazyPut<MainUserController>(() => MainUserController());

    //* HOME SUPER ADMIN CONTROLLER
    Get.lazyPut<HomeSuperAdminController>(() => HomeSuperAdminController());

    //* HOME USER CONTROLLER
    Get.lazyPut<HomeUserController>(() => HomeUserController());

    //Home User Kecamatan
    Get.lazyPut<HomeAdminKecController>(() => HomeAdminKecController());

    //* ARTICLE USER CONTROLLER
    Get.lazyPut<ArticleController>(() => ArticleController());
  }
}
