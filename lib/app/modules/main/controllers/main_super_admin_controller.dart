import 'package:get/get.dart';

class MainAdminController extends GetxController {
  final indexStack = 0.obs;

  void setDestinationSelected(int value) => indexStack.value = value;
}
