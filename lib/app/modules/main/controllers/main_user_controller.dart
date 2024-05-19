import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../routes/app_pages.dart';
import '../../../widgets/loader.dart';
import '../../detail_pkk/services/detail_pkk_services.dart';
import 'package:http/http.dart' as http;
import '../../init/controllers/init_controller.dart';

class MainUserController extends GetxController {
  late final InitController initC;
  late final GlobalKey<ScaffoldState> scaffoldKey;

  final indexStack = 0.obs;
  final isActivePushNotifications = false.obs;
  final isDarkMode = false.obs;
  final selectedItemNavDrawer = 0.obs;

  @override
  void onInit() {
    super.onInit();

    if (Get.isRegistered<InitController>()) {
      initC = Get.find<InitController>();
    }

    scaffoldKey = GlobalKey<ScaffoldState>();
    checkStateThemeMode();
  }

  void checkStateThemeMode() async =>
      isDarkMode.value = await initC.storage.read(key: 'isDarkMode') == 'true';

  void setPushNotifications(bool value) => isActivePushNotifications.toggle();

  Future<void> setDarkMode(bool value) async {
    isDarkMode.toggle();

    Get.changeThemeMode((Get.isDarkMode) ? ThemeMode.light : ThemeMode.dark);

    await initC.storage.write(key: 'isDarkMode', value: value.toString());
  }

  final isLoading = false.obs;
  String? waNumber;

  Future<void> fetchData() async {
    try {
      final response = await http
          .get(Uri.parse('https://app2.tppkk-bitung.com/api/nomor-wa'));

      if (response.statusCode == 200) {
        final jsonResponse = json.decode(response.body);
        final dataList = jsonResponse['data'] as List<dynamic>;
        if (dataList.isNotEmpty) {
          waNumber = dataList[0]['was'] as String?;
        } else {
          waNumber = null;
        }
      } else {
        waNumber = null;
      }
    } catch (e) {
      print('Error fetching data: $e');
      waNumber = null;
    }
  }

  void setDestinationSelected(
    int value,
  ) async {
    switch (value) {
      case 2:
        {
          Get.dialog(Center(child: CircularProgressIndicator()));
          await fetchData();
          Get.back();

          print(waNumber);
          openWhatsApp('+${waNumber}');

          indexStack.value = indexStack.value;
        }
      case 3:
        {
          indexStack.value = indexStack.value;
          isLoading.value = true;
          Get.dialog(
            Dialog.fullscreen(
              backgroundColor: Colors.transparent,
              child: Obx(() => isLoading.value ? Loader() : SizedBox()),
            ),
          );

          final image = await DetailPkkServices().getImage('menu-struktur');

          if (image != '') {
            Get.back();
            isLoading.value = false;

            Get.dialog(
              Stack(
                children: [
                  InteractiveViewer(
                    clipBehavior: Clip.none,
                    maxScale: 5,
                    child: Center(
                        child: Image(
                      image: CachedNetworkImageProvider(
                          'https://tppkk-bitung.com/images/$image'),
                    )),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.back(),
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ],
                  ),
                ],
              ),
            );
          } else {
            isLoading.value = true;
          }
          print(image);

          // openPopUp();
        }
      case 4:
        openDrawer();
      default:
        indexStack.value = value;
    }
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
              await initC.storage.deleteAll();
              Get.offAllNamed(Routes.LOGIN);
            },
            child: const Text('Ya'),
          ),
        ],
      ),
    );
  }

  void openWhatsApp(String phoneNumber) async {
    final url = "https://wa.me/$phoneNumber";

    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
    } else {
      throw "Tidak dapat membuka WhatsApp";
    }
  }

  //! TIDAK DIGUNAKAN
  // void openPopUp() {
  //   final size = Get.size;

  //   Get.dialog(
  //     AlertDialog(
  //       content: Container(
  //         width: double.infinity,
  //         height: size.height / 2,
  //         decoration: const BoxDecoration(
  //           image: DecorationImage(
  //             image: AssetImage('assets/img/logo.png'),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
