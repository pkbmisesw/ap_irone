import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:silahan_kawan/app/data/db/item_menu_db.dart';
import 'package:silahan_kawan/app/data/models/article/item_article_model.dart';
import 'package:silahan_kawan/app/data/models/auth/login/users_model.dart';
import 'package:silahan_kawan/app/data/models/banner/item_banner_model.dart';
import 'package:silahan_kawan/app/modules/home/controllers/home_user_controller.dart';
import 'package:silahan_kawan/app/routes/app_pages.dart';
import 'package:silahan_kawan/app/shared/shared_method.dart';
import 'package:silahan_kawan/app/shared/shared_theme.dart';
import 'package:silahan_kawan/app/shared/values.dart';
import 'package:silahan_kawan/app/utils/constants_endpoints.dart';
import 'package:silahan_kawan/app/utils/constants_item_menu.dart';
import 'package:silahan_kawan/app/widgets/dialog/custom_dialog.dart';
import 'package:silahan_kawan/app/widgets/errors/card_error_item.dart';
import 'package:silahan_kawan/app/widgets/loader.dart';
import 'package:silahan_kawan/theme.dart';

import '../../detail_pkk/services/detail_pkk_services.dart';
import 'trymap.dart';

class HomeUserView extends GetView<HomeUserController> {
  final UsersModel? users;

  HomeUserView({
    Key? key,
    this.users,
  }) : super(key: key);

  final RxBool isLoading = false.obs;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    AppBar builderAppbar() {
      return AppBar(
        backgroundColor: bgWhite,
        automaticallyImplyLeading: false,
        toolbarHeight: size.height * 0.08,
        title: SizedBox(
          width: size.width / 1.8,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Selamat ${checkDayMessage()}',
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              Text(
                users?.nama ?? '-',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () => controller.openDrawer(),
            child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Image.asset('assets/logo/logoPng.png')
                //  CachedNetworkImage(
                //   imageUrl: 'https://tppkk-bitung.com/images/logoza.png',
                //   imageBuilder: (context, imageProvider) => CircleAvatar(
                //     // maxRadius: SharedSize.px24,
                //     backgroundImage: imageProvider,
                //   ),
                //   placeholder: (context, url) => const CircleAvatar(
                //           // maxRadius: SharedSize.px24
                //           )
                //       .animate(onPlay: (controller) => controller.repeat())
                //       .shimmer(
                //         duration: 1800.ms,
                //         color: theme.colorScheme.onSurface,
                //       ),
                //   errorWidget: (context, url, error) => const CircleAvatar(
                //     // maxRadius: SharedSize.px24,
                //     backgroundImage:
                //         AssetImage('assets/img/placeholder_no_photo.png'),
                //   ),
                // ),
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
          } else {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: CardErrorItem(
                onPressed: () => controller.getBanner(),
              ),
            );
          }
        },
      );
    }

    Widget builderDialogEvent() {
      return CustomDialog(
        title: Text(
          'Perhatian',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: SharedTheme.titleTextStyle,
          ),
        ),
        content: const Text('Sedang dalam Pengembangan'),
        contentTextStyle: theme.textTheme.bodyLarge,
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text('Oke'),
          ),
        ],
      );
    }

    Widget builderBottomSheetLetter() {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 21),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Pilih Jenis Surat',
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.bold,
                fontFamily: SharedTheme.titleTextStyle,
              ),
            ),
            const SizedBox(height: 4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                    showDialog(
                      context: context,
                      builder: (context) => builderDialogEvent(),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/ic/ic_incoming_letter.png',
                        width: size.width * 0.3,
                      ),
                      Text(
                        'Surat Masuk',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
                InkWell(
                  onTap: () {
                    Get.back();
                    showDialog(
                      context: context,
                      builder: (context) => builderDialogEvent(),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        'assets/ic/ic_outgoing_letter.png',
                        width: size.width * 0.3,
                      ),
                      Text(
                        'Surat Keluar',
                        style: theme.textTheme.bodyLarge,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget builderItemMenu(ItemMenuDB itemMenu, int index) {
      return GestureDetector(
          onTap: () async {
            debugPrint("${itemMenu.id}");
            if (index == 3) {
              Get.toNamed(Routes.DETAIL_PKK);
            } else if (itemMenu.image != null) {
              isLoading.value = true;
              showDialog(
                context: context,
                builder: (context) => Dialog.fullscreen(
                  backgroundColor: Colors.transparent,
                  child: Obx(() => isLoading.value ? Loader() : SizedBox()),
                ),
              );
              String imageData() {
                if (itemMenu.title == 'Capaian Program') {
                  return 'menu-capaian';
                } else if (itemMenu.title == 'Prestasi') {
                  return 'menu-prestasi';
                } else {
                  return '';
                }
              }

              final image = await DetailPkkServices().getImage(imageData());

              if (image != '') {
                Get.back();
                isLoading.value = false;
                // ignore: use_build_context_synchronously
                detailPicture(
                  context,
                  CachedNetworkImageProvider(
                      'https://tppkk-bitung.com/images/$image'),
                );
              } else {
                isLoading.value = true;
              }
            } else if (itemMenu.routeName != null) {
              Get.toNamed(itemMenu.routeName!);
            } else {
              switch (itemMenu.id) {
                case 3:
                  showModalBottomSheet(
                    context: context,
                    showDragHandle: true,
                    builder: (context) => builderBottomSheetLetter(),
                  );
                case 4:
                  showDialog(
                    context: context,
                    builder: (context) => builderDialogEvent(),
                  );
                case 5:
                  showDialog(
                    context: context,
                    builder: (context) => builderDialogEvent(),
                  );
                case 6:
                  Get.to(() => TryMap());

                case 7:
                  showDialog(
                    context: context,
                    builder: (context) => builderDialogEvent(),
                  );
                case 8:
                  showDialog(
                    context: context,
                    builder: (context) => builderDialogEvent(),
                  );
              }
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: bgYellow.withOpacity(0.3),
                ),
                child: itemMenu.assetsImg != null
                    ? Image.asset(itemMenu.assetsImg!,
                        width: 38,
                        color: itemMenu.color ?? null,
                        height:
                            38) // Menambahkan Image.asset jika imagePath ada
                    : Icon(itemMenu.icon, color: Color(0xffB00020), size: 38),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                itemMenu.title,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: basicBlack,
                    fontSize: 14),
              )
            ],
          ));
    }

    Widget builderMenu() {
      return GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: .9,
          crossAxisCount: 4,
          mainAxisSpacing: size.height / 62,
        ),
        itemBuilder: (context, index) =>
            builderItemMenu(listMenuUser[index], index),
        itemCount: listMenuUser.length,
      );
    }

    Widget builderItemNews(ItemArticleModel? data) {
      final sizeWidthItem = size.width - (size.width / 2.5);

      return InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => controller.moveToArticleDetail(
          id: data?.id.toString() ?? '0',
          itemArticle: data!,
        ),
        child: SizedBox(
          width: sizeWidthItem,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.2,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: CachedNetworkImage(
                    imageUrl: data != null && data.gambar != ''
                        ? '${ConstantsEndpoints.urlImgBanner}${data.gambar}'
                        : 'https://www.toprankindonesia.com/wp-content/uploads/2023/10/4.-Apa-itu-404-not-Found-scaled.jpg',
                    imageBuilder: (context, imageProvider) => Image(
                      image: imageProvider,
                      fit: BoxFit.cover,
                    ),
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Container(
                      color: theme.colorScheme.surfaceVariant,
                    )
                            .animate(
                              onPlay: (controllerAnimate) =>
                                  controllerAnimate.repeat(),
                            )
                            .shimmer(
                              duration: 1800.ms,
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.2),
                            ),
                    errorWidget: (context, url, error) {
                      return Image.asset(
                        'assets/img/no_image.jpg',
                        fit: BoxFit.cover,
                      );
                    },
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data?.nama ?? '-',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontFamily: SharedTheme.titleTextStyle,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ).animate(target: (data != null) ? 0 : 1).swap(
                        delay: Duration.zero,
                        builder: (context, child) => Container(
                          height: 32,
                          color: theme.colorScheme.surfaceVariant,
                        )
                            .animate(
                                onPlay: (controller) => controller.repeat())
                            .shimmer(
                              duration: 1800.ms,
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.2),
                            ),
                      ),
                  const SizedBox(height: 4),
                  Text(
                    formatTimeAgo(data?.tgl),
                    style: theme.textTheme.labelSmall,
                  ).animate(target: (data != null) ? 0 : 1).swap(
                        builder: (context, child) => Container(
                          height: 16,
                          width: sizeWidthItem / 2,
                          color: theme.colorScheme.surfaceVariant,
                        )
                            .animate(
                                onPlay: (controller) => controller.repeat())
                            .shimmer(
                              duration: 1800.ms,
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.2),
                            ),
                      ),
                  const SizedBox(height: 4),
                  Text(
                    'Dari ${data?.penulis ?? '-'}',
                    style: theme.textTheme.labelMedium,
                  ).animate(target: (data != null) ? 0 : 1).swap(
                        builder: (context, child) => Container(
                          height: 16,
                          width: sizeWidthItem / 2,
                          color: theme.colorScheme.surfaceVariant,
                        )
                            .animate(
                                onPlay: (controller) => controller.repeat())
                            .shimmer(
                              duration: 1800.ms,
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.2),
                            ),
                      ),
                ],
              )
            ],
          ),
        ),
      );
    }

    Widget builderNews({List<ItemArticleModel>? dataNews}) {
      return ListView.builder(
        scrollDirection: Axis.horizontal,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final sizeData = (dataNews != null) ? dataNews.length - 1 : 3;
          var margin = const EdgeInsets.only(left: 16);

          if (index == 0) {
            margin = const EdgeInsets.only(left: 16);
          } else if (index == sizeData) {
            margin = const EdgeInsets.only(left: 16, right: 16);
          }

          return Container(
            margin: margin,
            child: builderItemNews(dataNews?[index]),
          );
        },
        itemCount: (dataNews != null) ? dataNews.length : 4,
      );
    }

    Widget builderFutureNews() {
      return FutureBuilder(
        future: controller.getPosting(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            final dataNews = snapshot.data!;

            return builderNews(dataNews: dataNews);
          } else if (snapshot.hasError) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: CardErrorItem(onPressed: () => controller.getPosting()),
            );
          } else {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              width: double.infinity,
              child: CardErrorItem(onPressed: () => controller.getPosting()),
            );
          }
        },
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
      key: controller.scaffoldKey,
      appBar: builderAppbar(),
      body: RefreshIndicator.adaptive(
        onRefresh: () {
          return Future.wait([
            controller.getBanner(),
            controller.getPosting(),
          ]);
        },
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    builderFutureSlider(),
                    const SizedBox(height: 12),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: builderMenu(),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Berita Terkini',
                            style: theme.textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.bold),
                          ),
                          TextButton(
                            onPressed: () => controller.moveToArticleByMenu(),
                            child: const Text(
                              'Lihat Semua',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      height: size.height * 0.32,
                      child: builderFutureNews(),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      endDrawer: builderNavDrawer(),
      onEndDrawerChanged: controller.setEndDrawerChanged,
    );
  }
}
