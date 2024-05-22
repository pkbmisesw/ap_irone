import 'package:carousel_slider/carousel_options.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irone/local_storage/local_storage_helper.dart';
import 'package:logger/logger.dart';
import 'package:irone/app/data/models/article/item_article_model.dart';
import 'package:irone/app/data/models/banner/item_banner_model.dart';
import 'package:irone/app/modules/init/controllers/init_controller.dart';
import 'package:irone/app/modules/main/controllers/main_user_controller.dart';
import 'package:irone/app/routes/app_pages.dart';
import 'package:irone/app/services/article_services.dart';
import 'package:irone/app/services/home_services.dart';

class HomeUserController extends GetxController {
  late final InitController initC;
  late final MainUserController mainUserC;
  late final HomeServices _homeServices;
  late final ArticleServices _articleServices;

  late final GlobalKey<ScaffoldState> scaffoldKey;

  final pageSlider = 0.obs;
  final isActivePushNotifications = false.obs;
  final isDarkMode = false.obs;
  final selectedItemNavDrawer = 0.obs;

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();

    if (Get.isRegistered<InitController>()) {
      initC = Get.find<InitController>();
    }

    if (Get.isRegistered<MainUserController>()) {
      mainUserC = Get.find<MainUserController>();
    }

    _homeServices = HomeServices();
    _articleServices = ArticleServices();
    scaffoldKey = GlobalKey<ScaffoldState>();

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

              await SharedPreferenceHelper.setLogin(0);
              await initC.storage.deleteAll();
              Get.offAllNamed(Routes.LOGIN);
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }

  Future<List<ItemBannerModel>> getBanner() async {
    try {
      final resBanner = await _homeServices.getBanner();

      if (resBanner.data != null) {
        return resBanner.data!;
      }
    } on DioException catch (e) {
      logger.e('Error: $e');
      logger.e('Error Type: ${e.type}');
      return Future.error(e);
    }

    return [];
  }

  Future<List<ItemArticleModel>> getPosting() async {
    try {
      final resPosting = await _articleServices.getPosting();

      if (resPosting.data != null) {
        List<ItemArticleModel> dataFilter =
            await compute(filterNews, resPosting.data!);
        return dataFilter;
      }
    } on DioException catch (e) {
      logger.e('Error: $e');
      logger.e('Error Type: ${e.type}');
      return Future.error(e);
    }

    return [];
  }

  static List<ItemArticleModel> filterNews(List<ItemArticleModel> data) {
    return data.where((element) => element.stat == 1).toList();
  }

  void moveToArticleByMenu() => mainUserC.setDestinationSelected(1);

  void moveToArticleDetail({
    required String id,
    required ItemArticleModel itemArticle,
  }) =>
      Get.toNamed(
        '${Routes.ARTICLE}/$id',
        arguments: itemArticle,
      );

  void moveToLetter(int type) => Get.toNamed(
        Routes.LETTER,
        arguments: type,
      );
}
