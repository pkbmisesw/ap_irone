import 'package:carousel_slider/carousel_options.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:irone/app/data/models/banner/item_banner_model.dart';
import 'package:irone/app/services/home_services.dart';

import '../../../routes/app_pages.dart';
import '../../init/controllers/init_controller.dart';

class HomeAdminKecController extends GetxController {
  late final InitController initC;

  final HomeServices homeServices = HomeServices();

  late final GlobalKey<ScaffoldState> scaffoldKey;

  final pageSlider = 0.obs;
  final isActivePushNotifications = false.obs;
  final isDarkMode = false.obs;
  final selectedItemNavDrawer = 0.obs;

  final logger = Logger();

  final isLoading = true.obs;
  @override
  void onInit() {
    super.onInit();

    if (Get.isRegistered<InitController>()) {
      initC = Get.find<InitController>();
    }

    scaffoldKey = GlobalKey<ScaffoldState>();

    fetchData();
    checkStateThemeMode();
  }

  void checkStateThemeMode() async =>
      isDarkMode.value = await initC.storage.read(key: 'isDarkMode') == 'true';

  void setPageSlider(int index, CarouselPageChangedReason reason) =>
      pageSlider.value = index;

  void setPushNotifications(bool value) => isActivePushNotifications.toggle();

  Future<void> setDarkMode(bool value) async {
    isDarkMode.toggle();

    Get.changeThemeMode((Get.isDarkMode) ? ThemeMode.light : ThemeMode.dark);

    await initC.storage.write(key: 'isDarkMode', value: value.toString());
  }

  void openDrawer() {
    scaffoldKey.currentState!.openEndDrawer();
  }

  void openLeftDrawer() {
    scaffoldKey.currentState!.openDrawer();
  }

  void selectedNavDrawerIndex(int value) {
    selectedItemNavDrawer.value = value;

    switch (value) {
      case 0:
        setPushNotifications(!isActivePushNotifications.value);
        break;
      case 1:
        setDarkMode(!isDarkMode.value);
        break;
      case 2:
        // bantuan page
        break;
      case 3:
        handleLogOut();
        break;
      default:
    }
  }

  void setEndDrawerChanged(bool isOpened) {
    if (!isOpened) {
      selectedItemNavDrawer.value = 10;
    }
  }

  void handleLogOut() {
    Get.dialog(
      AlertDialog(
        icon: const Icon(Icons.exit_to_app_rounded),
        title: const Text(
          'Konfirmasi',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: const Text('Apakah anda yakin ingin keluar?'),
        actions: [
          TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('Tidak'),
          ),
          TextButton(
            onPressed: () async {
              // remove all sharedpreferences
              await initC.storage.deleteAll();
              Get.offAllNamed(Routes.LOGIN);
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }

  //banner
  RxList<ItemBannerModel> listbanner = <ItemBannerModel>[].obs;
  List<String> valueSlider = [];
  void fetchData() async {
    final data = await homeServices.getBanner();
    final List<ItemBannerModel>? dataValue = data.data;

    listbanner.value.assignAll(dataValue ?? []);

    // Ambil nilai slider dari setiap ItemBannerModel
    List<String> sliderValues =
        listbanner.map((item) => item.slider ?? "").toList();
    valueSlider.assignAll(sliderValues);
    isLoading.value = false;
    // Cetak atau lakukan sesuatu dengan sliderValues
    print(sliderValues);
  }
}
