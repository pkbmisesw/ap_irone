import 'package:get/get.dart';

import '../controllers/law_controller.dart';

class LawBinding extends Bindings {
  @override
  void dependencies() => Get.lazyPut<LawController>(() => LawController());
}
