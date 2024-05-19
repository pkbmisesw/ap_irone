import 'package:get/get.dart';

import '../controllers/detail_pkk_controller.dart';

class DetailPkkBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DetailPkkController>(
      () => DetailPkkController(),
    );
  }
}
