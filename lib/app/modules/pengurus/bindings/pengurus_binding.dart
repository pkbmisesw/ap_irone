import 'package:get/get.dart';

import '../controllers/pengurus_controller.dart';

class PengurusBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PengurusController>(
      () => PengurusController(),
    );
  }
}
