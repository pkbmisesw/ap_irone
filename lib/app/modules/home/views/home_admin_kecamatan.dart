import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:silahan_kawan/app/data/db/item_menu_db.dart';
import 'package:silahan_kawan/app/modules/admin_kec/admin_kec_data_rekap/screen/data_rekap_screen.dart';
import 'package:silahan_kawan/app/modules/data_rekap/screen/data_rekap_barchart_screen.dart';
import 'package:silahan_kawan/app/modules/data_rekap/screen/data_rekap_linechart_screen.dart';
import 'package:silahan_kawan/app/modules/data_rekap/screen/data_rekap_piechart_screen.dart';
import 'package:silahan_kawan/app/modules/data_rekap/screen/data_rekap_screen.dart';
import 'package:silahan_kawan/app/modules/data_rekap/screen/data_rekap_table_screen.dart';
import 'package:silahan_kawan/app/modules/data_rekap/widget/sizedbox_extension.dart';
// import 'package:silahan_kawan/app/modules/data_umum/screen/data_umum_screen.dart';
// import 'package:silahan_kawan/app/modules/data_rekap/screen/data_rekap_screen.dart';
// import 'package:silahan_kawan/app/modules/data_umum/screen/data_umum_screen.dart';
import 'package:silahan_kawan/app/modules/home/widget/widget.dart';
import 'package:silahan_kawan/app/routes/app_pages.dart';
import 'package:silahan_kawan/app/utils/constants_item_banner.dart';
import 'package:silahan_kawan/app/utils/constants_item_menu.dart';
import 'package:silahan_kawan/app/widgets/loader.dart';
import 'package:silahan_kawan/theme.dart';
import 'package:remixicon/remixicon.dart';

import '../../admin_kec/admin_kec_data_pokjaa/screen/data_pokjaa_menu_screen.dart';
import '../../admin_kec/admin_kec_data_pokjab/screen/data_pokjab_menu_screen.dart';
import '../../admin_kec/admin_kec_data_pokjac/screen/data_pokjac_screen.dart';
import '../../admin_kec/admin_kec_data_pokjad/screen/data_pokjad_screen.dart';
import '../../admin_kec/admin_kec_data_rekap/screen/data_rekap_menu_screen_new.dart';
import '../../admin_kec/admin_kec_data_umum/screen/data_umum_menu_screen.dart';
import '../../data_rekap/screen/data_rekap_input_screen.dart';
import '../../data_umum/screen/data_umum_bar_chart_screen.dart';
import '../../data_umum/screen/data_umum_line_chart_screen.dart';
import '../../data_umum/screen/data_umum_list_screen.dart';
import '../../data_umum/screen/data_umum_pie_chart_screen.dart';
import '../../data_umum/screen/data_umum_table_screen.dart';
import '../controllers/home_admin_kecamatan_controller.dart';

class HomeAdminKecamatanView extends GetView<HomeAdminKecController> {
  HomeAdminKecamatanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    AppBar builderAppBar() {
      return AppBar(
        backgroundColor: bgWhite,
        title: Text(
          'TP PKK KOTA BITUNG',
          style: theme.textTheme.titleMedium
              ?.copyWith(fontWeight: FontWeight.bold, color: trueBlack),
        ),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            controller.openLeftDrawer();
          },
          icon: Icon(
            Remix.menu_line,
            color: trueBlack,
          ),
        ),
        actions: [
          GestureDetector(
            onTap: () => controller.openDrawer(),
            child: Image.asset(
              'assets/img/logo.png',
              width: size.width / 10,
            ),
          ),
          const SizedBox(width: 8),
        ],
      );
    }

    Widget builderItemSlider(String assetImg) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: 'https://tppkk-bitung.com/images/$assetImg' ??
              'https://img.freepik.com/free-vector/400-error-bad-request-concept-illustration_114360-1933.jpg?w=740&t=st=1705214670~exp=1705215270~hmac=5ecbfce69ae0d6e945aba0a82de909aaa739dcf51e4d2dc0cfc6dd7702a628a4',
          width: double.infinity,
          fit: BoxFit.fill,
        ),
      );
    }

    Widget builderSlider() {
      return Column(
        children: [
          CarouselSlider.builder(
            itemCount: controller.valueSlider.length,
            itemBuilder: (context, index, realIndex) =>
                builderItemSlider(controller.valueSlider[index]),
            options: CarouselOptions(
              height: size.height * 0.2,
              autoPlay: true,
              autoPlayInterval: 7000.ms,
              enlargeCenterPage: true,
              onPageChanged: controller.setPageSlider,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: listBanner.map(
              (element) {
                final index = listBanner.indexOf(element);
                return Obx(
                  () {
                    final pageSlider = controller.pageSlider.value;

                    return AnimatedContainer(
                      duration: 300.ms,
                      width: pageSlider == index
                          ? size.width / 18
                          : size.width / 48,
                      height: size.height / 100,
                      margin: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 4,
                      ),
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(
                            8), // Sesuaikan dengan ukuran width
                        color: pageSlider == index
                            ? bgRed
                            : theme.colorScheme.onSurface.withOpacity(0.3),
                      ),
                    );
                  },
                );
              },
            ).toList(),
          ),
        ],
      );
    }

    Widget builderItemMenu(ItemMenuDB itemMenu) {
      return InkWell(
          onTap: () {
            if (itemMenu.id == 1) {
              Get.to(() => AdminKecDataRekapHome());
            }
            if (itemMenu.id == 2) {
              Get.to(() => AdminKecDataUmumMenuScreen());
            }
            if (itemMenu.id == 3) {
              Get.to(() => AdminKecDataPokjaaMenuScreen());
            }
            if (itemMenu.id == 4) {
              Get.to(() => AdminKecDataPokjabMenuScreen());
            }
            if (itemMenu.id == 5) {
              Get.to(() => AdminKecDataPokjacScreen());
            }
            if (itemMenu.id == 6) {
              Get.to(() => AdminKecDataPokjadScreen());
            }
            if (itemMenu.id == 7) {
              Get.toNamed(Routes.INPUT_DATA);
            }
            if (itemMenu.id == 9) {
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
                        await controller.initC.storage.deleteAll();
                        Get.offAllNamed(Routes.LOGIN);
                      },
                      child: const Text('Ya'),
                    ),
                  ],
                ),
              );
            }
          },
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: bgGreyLite.withOpacity(0.3),
                ),
                child: itemMenu.imagePath != null
                    ? Image.asset(itemMenu.imagePath!,
                        width: 38,
                        color: itemMenu.color ?? null,
                        height:
                            38) // Menambahkan Image.asset jika imagePath ada
                    : Icon(itemMenu.icon, color: Color(0xffB00020), size: 38),
              ),
              5.heightBox,
              Text(
                itemMenu.title,
                style: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.bold, color: basicBlack),
              )
            ],
          ));
    }

    Widget builderMenu() {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: size.height / 62,
        ),
        itemBuilder: (context, index) =>
            builderItemMenu(listMenuKecamatan[index]),
        itemCount: listMenuKecamatan.length,
      );
    }

    NavigationDrawerDestination buildMenuDrawer(
      String image,
      String tittle,
    ) {
      return NavigationDrawerDestination(
        icon: Image.asset(
          image,
          height: 24,
          width: 24,
        ),
        label: Expanded(
          child: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(tittle),
                Icon(Remix.arrow_right_s_line),
              ],
            ),
          ),
        ),
        selectedIcon: Icon(Icons.help_rounded),
      );
    }

    Widget builderNavLeftDrawer() {
      return Obx(
        () => NavigationDrawer(
          selectedIndex: controller.selectedItemNavDrawer.value,
          children: [
            const NavigationDrawerDestination(
              icon: Icon(Remix.menu_line),
              label: Text('Menu'),
              selectedIcon: Icon(Remix.menu_line),
            ),
            ExpandedChildren(
              tittle: 'Data Rekap',
              image: 'assets/ic/drekap.png',
              children: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(children: [
                  ExpandedTile(
                      image: 'assets/img/input.png',
                      tittle: "Input Data",
                      onTap: () {
                        Get.to(() => InputDataViewScreen());
                      }),
                  ExpandedTile(
                      image: 'assets/img/list.png',
                      tittle: "List Data",
                      onTap: () {
                        Get.to(() => DataRekapScreen());
                      }),
                  ExpandedTile(
                      image: 'assets/img/table.png',
                      tittle: "Table Chart",
                      onTap: () {
                        Get.to(() => TableData());
                      }),
                  ExpandedTile(
                      image: 'assets/img/pie.png',
                      tittle: "Pie Chart",
                      onTap: () {
                        Get.to(() => DataRekapPieScreen());
                      }),
                  ExpandedTile(
                      image: 'assets/img/bar.png',
                      tittle: "Bar Chart",
                      onTap: () {
                        Get.to(() => DataRekapBarScreen());
                      }),
                  ExpandedTile(
                      image: 'assets/img/table.png',
                      tittle: "Line Chart",
                      onTap: () {
                        Get.to(() => DataRekapLineScreen());
                      }),
                ]),
              ),
            ),
            ExpandedChildren(
              tittle: 'Data Umum',
              image: 'assets/ic/dumum.png',
              children: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(children: [
                  ExpandedTile(
                      image: 'assets/img/input.png',
                      tittle: "Input Data",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/list.png',
                      tittle: "List Data",
                      onTap: () {
                        Get.to(() => DataUmumListScreen());
                      }),
                  ExpandedTile(
                      image: 'assets/img/table.png',
                      tittle: "Table Chart",
                      onTap: () {
                        Get.to(() => TableDataUmumScreen());
                      }),
                  ExpandedTile(
                      image: 'assets/img/pie.png',
                      tittle: "Pie Chart",
                      onTap: () {
                        Get.to(() => DataUmumPieScreen());
                      }),
                  ExpandedTile(
                      image: 'assets/img/bar.png',
                      tittle: "Bar Chart",
                      onTap: () {
                        Get.to(() => DataRekapDataUmumBarScreen());
                      }),
                  ExpandedTile(
                      image: 'assets/img/table.png',
                      tittle: "Line Chart",
                      onTap: () {
                        Get.to(() => DataUmumLineScreen());
                      }),
                ]),
              ),
            ),
            ExpandedChildren(
              tittle: 'Data Pokja 1',
              image: 'assets/ic/pokja1.png',
              children: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(children: [
                  ExpandedTile(
                      image: 'assets/img/input.png',
                      tittle: "Input Data",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/list.png',
                      tittle: "List Data",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/table.png',
                      tittle: "Table Chart",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/pie.png',
                      tittle: "Pie Chart",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/bar.png',
                      tittle: "Bar Chart",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/table.png',
                      tittle: "Line Chart",
                      onTap: () {}),
                ]),
              ),
            ),
            ExpandedChildren(
              tittle: 'Data Pokja 2',
              image: 'assets/ic/pokja2.png',
              children: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(children: [
                  ExpandedTile(
                      image: 'assets/img/input.png',
                      tittle: "Input Data",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/list.png',
                      tittle: "List Data",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/table.png',
                      tittle: "Table Chart",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/pie.png',
                      tittle: "Pie Chart",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/bar.png',
                      tittle: "Bar Chart",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/table.png',
                      tittle: "Line Chart",
                      onTap: () {}),
                ]),
              ),
            ),
            ExpandedChildren(
              tittle: 'Data Pokja 3',
              image: 'assets/ic/pokja3.png',
              children: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(children: [
                  ExpandedTile(
                      image: 'assets/img/input.png',
                      tittle: "Input Data",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/list.png',
                      tittle: "List Data",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/table.png',
                      tittle: "Table Chart",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/pie.png',
                      tittle: "Pie Chart",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/bar.png',
                      tittle: "Bar Chart",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/table.png',
                      tittle: "Line Chart",
                      onTap: () {}),
                ]),
              ),
            ),
            ExpandedChildren(
              tittle: 'Data Pokja 4',
              image: 'assets/ic/pokja4.png',
              children: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(children: [
                  ExpandedTile(
                      image: 'assets/img/input.png',
                      tittle: "Input Data",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/list.png',
                      tittle: "List Data",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/table.png',
                      tittle: "Table Chart",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/pie.png',
                      tittle: "Pie Chart",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/bar.png',
                      tittle: "Bar Chart",
                      onTap: () {}),
                  ExpandedTile(
                      image: 'assets/img/table.png',
                      tittle: "Line Chart",
                      onTap: () {}),
                ]),
              ),
            ),
            ExpandedChildren(
              tittle: 'Setting',
              image: 'assets/ic/setting.png',
              children: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(children: [
                  ExpandedTile(
                      image: 'assets/ic/logout.png',
                      tittle: "Logout",
                      onTap: () {
                        controller.handleLogOut();
                      }),
                ]),
              ),
            ),
          ],
        ),
      );
    }

    Widget builderNavDrawer() {
      return Obx(
        () => NavigationDrawer(
          selectedIndex: controller.selectedItemNavDrawer.value,
          onDestinationSelected: controller.selectedNavDrawerIndex,
          children: [
            NavigationDrawerDestination(
              icon: const Icon(Icons.notifications_outlined),
              label: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Push Notifikasi'),
                        Text('Aktifkan Notifikasi'),
                      ],
                    ),
                    Switch(
                      value: controller.isActivePushNotifications.value,
                      onChanged: controller.setPushNotifications,
                    ),
                  ],
                ),
              ),
              selectedIcon: const Icon(Icons.notifications_rounded),
            ),
            NavigationDrawerDestination(
              icon: Icon(
                (controller.isDarkMode.value)
                    ? Icons.dark_mode_outlined
                    : Icons.light_mode_outlined,
              ),
              label: Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Mode Gelap'),
                    Switch(
                      value: controller.isDarkMode.value,
                      onChanged: controller.setDarkMode,
                    ),
                  ],
                ),
              ),
              selectedIcon: Icon(
                (controller.isDarkMode.value)
                    ? Icons.dark_mode_rounded
                    : Icons.light_mode_rounded,
              ),
            ),
            const NavigationDrawerDestination(
              icon: Icon(Icons.help_outline),
              label: Text('Bantuan'),
              selectedIcon: Icon(Icons.help_rounded),
            ),
            const NavigationDrawerDestination(
              icon: Icon(Icons.logout_outlined),
              label: Text('Log Out'),
              selectedIcon: Icon(Icons.logout_rounded),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: builderAppBar(),
      key: controller.scaffoldKey,
      body: Obx(
        () => controller.isLoading.value
            ? Loader()
            : SingleChildScrollView(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    children: [
                      builderSlider(),
                      const SizedBox(height: 14),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          children: [
                            const SizedBox(height: 12),
                            builderMenu(),
                            const SizedBox(height: 12),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
      drawer: builderNavLeftDrawer(),
      endDrawer: builderNavDrawer(),
      onEndDrawerChanged: controller.setEndDrawerChanged,
    );
  }
}
