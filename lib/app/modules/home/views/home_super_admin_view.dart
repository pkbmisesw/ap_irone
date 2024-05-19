import 'package:irone/app/data/db/item_menu_db.dart';
import 'package:irone/app/data/models/auth/login/users_model.dart';
import 'package:irone/app/data/models/banner/item_banner_model.dart';
import 'package:irone/app/modules/data_rekap/widget/sizedbox_extension.dart';
import 'package:irone/app/modules/home/controllers/home_super_admin_controller.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:irone/app/modules/super_admin/data_pokjac/view/super_admin_data_pokjac.dart';
import 'package:irone/app/modules/super_admin/data_pokjad/view/super_admin_data_pokjad.dart';
import 'package:irone/app/modules/super_admin/data_rekap_all/view/data_rekap_all.dart';
import 'package:irone/app/routes/app_pages.dart';
import 'package:irone/app/shared/values.dart';
import 'package:irone/app/utils/constants_endpoints.dart';
import 'package:irone/app/utils/constants_item_menu.dart';
import 'package:irone/app/widgets/errors/card_error_item.dart';
import 'package:irone/theme.dart';
import 'package:remixicon/remixicon.dart';

import '../../super_admin/data_pokjaa/view/super_admin_data_pokjaa.dart';
import '../../super_admin/data_pokjab/view/super_admin_data_pokjab.dart';
import '../../super_admin/data_rekap/view/super_admin_data_rekap.dart';
import '../../super_admin/data_umum/view/super_admin_data_umum.dart';

class HomeSuperAdminView extends GetView<HomeSuperAdminController> {
  final UsersModel? users;

  const HomeSuperAdminView({
    Key? key,
    this.users,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    AppBar builderAppbar() {
      return AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: size.height * 0.08,
        backgroundColor: bgWhite,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Sistem Informasi Manajemen',
              style: TextStyle(
                fontSize: 14,
              ),
            ),
            Text(
              'PKK Kota Bitung',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () => controller.openDrawer(),
            child: Image.asset(
              'assets/img/logo.png',
              width: size.width / 8,
            ),
          ),
          const SizedBox(width: 8),
        ],
      );
    }

    Widget builderItemSlider(String? url) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child: CachedNetworkImage(
          imageUrl: '${ConstantsEndpoints.urlImgBanner}$url',
          imageBuilder: (context, imageProvider) => Image(
            width: double.infinity,
            image: imageProvider,
            fit: BoxFit.fill,
          ),
          progressIndicatorBuilder: (context, url, downloadProgress) => Center(
            child: Container(
              width: double.infinity,
              color: theme.colorScheme.surfaceVariant,
            )
                .animate(
                    onPlay: (controllerAnimate) => controllerAnimate.repeat())
                .shimmer(
                  duration: 1800.ms,
                  color: theme.colorScheme.onSurface.withOpacity(0.2),
                ),
          ),
          errorWidget: (context, url, error) => Image.asset(
            'assets/img/no_image.jpg',
            width: double.infinity,
            fit: BoxFit.fill,
          ),
        ),
      );
    }

    Widget builderSlider({List<ItemBannerModel>? dataBanner}) {
      return Column(
        children: [
          CarouselSlider.builder(
            itemCount: (dataBanner != null) ? dataBanner.length : 2,
            itemBuilder: (context, index, realIndex) =>
                builderItemSlider(dataBanner?[index].slider),
            options: CarouselOptions(
              height: size.height * 0.15,
              autoPlay: true,
              autoPlayInterval: 7000.ms,
              enlargeCenterPage: true,
              viewportFraction: 0.9,
              onPageChanged: controller.setPageSlider,
            ),
          ),
          const SizedBox(height: 8),
          (dataBanner != null)
              ? Row(
                  mainAxisSize: MainAxisSize.min,
                  children: dataBanner.map(
                    (element) {
                      final index = dataBanner.indexOf(element);
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
                                  ? theme.colorScheme.primaryContainer
                                  : theme.colorScheme.onSurface
                                      .withOpacity(0.3),
                            ),
                          );
                        },
                      );
                    },
                  ).toList(),
                )
              : Container(),
        ],
      );
    }

    Widget builderFutureSlider() {
      return FutureBuilder(
        future: controller.getBanner(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            return builderSlider(dataBanner: snapshot.data);
          } else if (snapshot.hasError) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: CardErrorItem(
                onPressed: () => controller.getBanner(),
              ),
            );
          }

          return builderSlider();
        },
      );
    }

    Widget builderItemMenu(ItemMenuDB itemMenu) {
      return GestureDetector(
        onTap: () {
          if (itemMenu.id == 1) {
            Get.to(() => SuperAdminDataRekap());
          }
          if (itemMenu.id == 2) {
            Get.to(() => SuperAdminDataUmum());
          }
          if (itemMenu.id == 3) {
            Get.to(() => SuperAdminDataPokja());
          }
          if (itemMenu.id == 4) {
            Get.to(() => SuperAdminDataPokjab());
          }
          if (itemMenu.id == 5) {
            Get.to(() => SuperAdminDataPokjac());
          }
          if (itemMenu.id == 6) {
            Get.to(() => SuperAdminDataPokjad());
          }
          if (itemMenu.id == 7) {
            Get.toNamed(Routes.LAW);
          }
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: theme.colorScheme.outline.withOpacity(0.3),
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12)),
              ),
              child: (itemMenu.assetsImg != null)
                  ? Image.asset(
                      itemMenu.assetsImg!,
                      width: 38,
                      color: theme.colorScheme.primary,
                    )
                  : Icon(
                      itemMenu.icon,
                      color: theme.colorScheme.primary,
                      size: 38,
                    ),
            ),
            const SizedBox(height: 4),
            Text(
              itemMenu.title,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
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
            builderItemMenu(listMenuSuperAdminPusat[index]),
        itemCount: listMenuSuperAdminPusat.length,
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

    List dataMenu = [
      {
        'id': 1,
        'image': 'assets/img/data-aggregation.png',
        'color': Color(0xffF2C4DE),
        'title': 'Data Rekap',
        'subtitle': 'Menu untuk melihat data rekap'
      },
      {
        'id': 2,
        'image': 'assets/img/statistics.png',
        'color': Color(0xff71B1D9),
        'title': 'Data Lainnya',
        'subtitle': 'Menu untuk melihat data lainnya'
      },
      {
        'id': 3,
        'image': 'assets/img/surat-masuk.png',
        'color': Color(0xffAED8F2),
        'title': 'Surat Masuk',
        'subtitle': 'Menu untuk melihat Surat Masuk'
      },
      {
        'id': 4,
        'image': 'assets/img/surat-keluar.png',
        'color': Color(0xffF2DEA2),
        'title': 'Surat Keluar',
        'subtitle': 'Menu untuk melihat Surat Keluar'
      },
      {
        'id': 5,
        'image': 'assets/img/law.png',
        'color': Color(0xffF2CDC4),
        'title': 'Produk Hukum',
        'subtitle': 'Menu untuk melihat Produk Hukum'
      },
    ];

    RxInt menuValue = 0.obs;
    return Scaffold(
      key: controller.scaffoldKey,
      appBar: builderAppbar(),
      body: RefreshIndicator.adaptive(
        onRefresh: () {
          return Future.wait([
            controller.getBanner(),
          ]);
        },
        child: CustomScrollView(
          slivers: [
            Obx(
              () => SliverToBoxAdapter(
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      builderFutureSlider(),
                      const SizedBox(height: 12),

                      menuValue.value == 1
                          ? Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      menuValue.value = 0;
                                    },
                                    child: Icon(
                                      Remix.arrow_left_s_line,
                                    ),
                                  ),
                                  12.heightBox,
                                ],
                              ),
                            )
                          : SizedBox(),
                      menuValue.value == 1
                          ? Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: builderMenu(),
                            )
                          : SizedBox(),

                      menuValue.value == 0
                          ? Container(
                              child: GridView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 2,
                                        mainAxisSpacing: size.height / 70,
                                        childAspectRatio: 1.1,
                                        crossAxisSpacing: 5),
                                padding: EdgeInsets.all(10),
                                itemBuilder: (context, index) => ClipRRect(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  child: InkWell(
                                    onTap: () {
                                      if (dataMenu[index]['title'] ==
                                              'Data Lainnya' &&
                                          menuValue.value == 0) {
                                        menuValue.value = 1;
                                      } else if (dataMenu[index]['id'] == 1) {
                                        Get.to(() => DataRekapAll());
                                      } else if (dataMenu[index]['id'] == 4) {
                                        controller
                                            .moveToLetter(type_outgoing_letter);
                                      } else if (dataMenu[index]['id'] == 3) {
                                        controller
                                            .moveToLetter(type_incoming_letter);
                                      } else if (dataMenu[index]['id'] == 5) {
                                        Get.toNamed(Routes.LAW);
                                      }
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(20),
                                      color: dataMenu[index]['color'],
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Image.asset(
                                            dataMenu[index]['image'],
                                            height: 32,
                                            width: 32,
                                          ),
                                          10.heightBox,
                                          Text(
                                            dataMenu[index]['title'],
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold,
                                                color: trueBlack),
                                          ),
                                          6.heightBox,
                                          Text(
                                            dataMenu[index]['subtitle'],
                                            style: TextStyle(
                                                fontSize: 12,
                                                fontWeight: FontWeight.w100,
                                                color: trueBlack),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                itemCount: dataMenu.length,
                              ),
                            )
                          : SizedBox(),
                      const SizedBox(height: 12),
                      // Container(
                      //   margin: const EdgeInsets.symmetric(horizontal: 16),
                      //   child: Row(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //     children: [
                      //       Column(
                      //         crossAxisAlignment: CrossAxisAlignment.start,
                      //         children: [
                      //           Text(
                      //             'Pengurus',
                      //             style: theme.textTheme.headlineSmall?.copyWith(
                      //               fontWeight: FontWeight.bold,
                      //               fontSize: 22,
                      //             ),
                      //           ),
                      //           const SizedBox(height: 2),
                      //           const Text('Pengurus PKK Kab. Belitung')
                      //         ],
                      //       ),
                      //       TextButton(
                      //         onPressed: () {},
                      //         child: const Text(
                      //           'Lihat Semua',
                      //           style: TextStyle(
                      //             fontSize: 16,
                      //             fontWeight: FontWeight.bold,
                      //           ),
                      //         ),
                      //       )
                      //     ],
                      //   ),
                      // ),
                      // const SizedBox(height: 16),
                      // SizedBox(
                      //   height: size.height * 0.25,
                      //   child: ListView.separated(
                      //     scrollDirection: Axis.horizontal,
                      //     shrinkWrap: true,
                      //     itemBuilder: (context, index) {
                      //       const sizeData = 3;
                      //       var margin = const EdgeInsets.only(left: 16);

                      //       if (index == 0) {
                      //         margin = const EdgeInsets.only(left: 16);
                      //       } else if (index == sizeData) {
                      //         margin = const EdgeInsets.only(left: 16, right: 16);
                      //       }

                      //       return Container(
                      //         width: size.width * 0.5,
                      //         margin: margin,
                      //         decoration: BoxDecoration(
                      //           color: theme.colorScheme.surfaceVariant,
                      //           borderRadius: BorderRadius.circular(16),
                      //         ),
                      //         child: Stack(
                      //           children: [
                      //             Positioned.fill(
                      //               child: ClipRRect(
                      //                 borderRadius: BorderRadius.circular(16),
                      //                 child: Image.asset(
                      //                   'assets/img/placeholder_no_photo.png',
                      //                   fit: BoxFit.cover,
                      //                 ),
                      //               ),
                      //             ),
                      //             Container(
                      //               width: (size.width * 0.5) / 1.2,
                      //               padding: const EdgeInsets.symmetric(
                      //                   horizontal: 16, vertical: 12),
                      //               decoration: BoxDecoration(
                      //                 color: theme.colorScheme.secondaryContainer,
                      //                 borderRadius: const BorderRadius.only(
                      //                   topLeft: Radius.circular(16),
                      //                   bottomRight: Radius.circular(32),
                      //                 ),
                      //               ),
                      //               child: Row(
                      //                 // mainAxisAlignment:
                      //                 //     MainAxisAlignment.spaceAround,
                      //                 children: [
                      //                   const Icon(Icons.account_box_rounded),
                      //                   const SizedBox(width: 12),
                      //                   Expanded(
                      //                     child: Text(
                      //                       'KETUA',
                      //                       style: theme.textTheme.labelMedium,
                      //                       maxLines: 2,
                      //                       overflow: TextOverflow.ellipsis,
                      //                     ),
                      //                   )
                      //                 ],
                      //               ),
                      //             )
                      //           ],
                      //         ),
                      //       );
                      //     },
                      //     separatorBuilder: (context, index) =>
                      //         const SizedBox(width: 21),
                      //     itemCount: 4,
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
      endDrawer: builderNavDrawer(),
      onEndDrawerChanged: controller.setEndDrawerChanged,
    );
  }
}
