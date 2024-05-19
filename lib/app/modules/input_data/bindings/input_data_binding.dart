import 'package:get/get.dart';

import '../controllers/input_data_controller.dart';

class InputDataBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InputDataController>(
      () => InputDataController(),
    );
  }
}
