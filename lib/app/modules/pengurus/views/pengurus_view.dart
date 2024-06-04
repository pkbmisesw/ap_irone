import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:silahan_kawan/app/data/models/pengurus/item_pengurus_model.dart';
import 'package:silahan_kawan/app/modules/pengurus/views/pengurus_detail.dart';
import 'package:silahan_kawan/app/shared/shared_theme.dart';
import 'package:silahan_kawan/app/utils/constants_endpoints.dart';
import 'package:silahan_kawan/theme.dart';
import 'package:remixicon/remixicon.dart';

import '../controllers/pengurus_controller.dart';

class PengurusView extends GetView<PengurusController> {
  const PengurusView({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    Widget builderItemPengurus(ItemPengurusModel? data) {
      return InkWell(
        onTap: () {
          showDialog(
            context: context,
            builder: (context) {
              return PengurusDetail(
                data: data,
              );
            },
          );
        },
        child: Column(
          key: ValueKey(data?.id),
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: size.height * 0.25,
              child: Stack(
                children: [
                  Positioned.fill(
                    top: 42,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: (data != null)
                          ? CachedNetworkImage(
                              imageUrl:
                                  '${ConstantsEndpoints.urlImgBanner}${data.gambar}',
                              fit: BoxFit.cover,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) => Center(
                                child: Container(
                                  width: double.infinity,
                                  color: theme.colorScheme.surfaceVariant,
                                ),
                              ),
                              errorWidget: (context, url, error) => Image.asset(
                                'assets/img/no_image.jpg',
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ).animate().fadeIn(duration: 800.ms),
                            )
                          : Container(
                              width: double.infinity,
                              color: theme.colorScheme.surfaceVariant,
                            ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: size.width * 0.02),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondaryContainer,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(16),
                        bottomRight: Radius.circular(32),
                      ),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: AutoSizeText(
                            (data == null) ? '' : data.jabatan ?? '-',
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.labelSmall?.copyWith(
                              fontFamily: SharedTheme.titleTextStyle,
                            ),
                            maxFontSize: 16,
                            minFontSize: 8,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              color:
                  (data == null) ? theme.colorScheme.secondaryContainer : null,
              child: AutoSizeText(
                data?.nama ?? '-',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              )
                  .animate(target: (data != null) ? 1 : 0)
                  .visibility(maintain: true),
            ),
          ],
        ),
      );
    }

    Widget builderPengurus({List<ItemPengurusModel>? data}) {
      return GridView.builder(
        padding: const EdgeInsets.all(16),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: size.width * 0.05,
          mainAxisSpacing: 12,
          childAspectRatio: size.aspectRatio * 1.25,
        ),
        itemBuilder: (context, index) => builderItemPengurus(data?[index]),
        itemCount: (data != null) ? data.length : 6,
      );
    }

    return Scaffold(
        appBar: AppBar(
          backgroundColor: bgWhite,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Remix.arrow_left_line,
              color: trueBlack,
            ),
          ),
          title: Obx(
            () => controller.isSearchMode.value
                ? TextField(
                    controller: controller.textController,
                    onChanged: (value) {
                      controller.onSearching();
                    },
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                  )
                : Text('Anggota',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: trueBlack,
                    )),
          ),
          actions: [
            IconButton(
              icon: Obx(
                () => Icon(
                  controller.isSearchMode.value ? Icons.close : Icons.search,
                  color: trueBlack,
                ),
              ),
              onPressed: () {
                controller.isSearchMode.toggle();
                if (!controller.isSearchMode.value) {
                  controller.textController.clear();
                }
                controller.valueSearch.value = '';
              },
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() => controller.dataFilter.isNotEmpty
                  ? GridView.builder(
                      padding: const EdgeInsets.all(16),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: size.width * 0.05,
                        mainAxisSpacing: 12,
                        childAspectRatio: size.aspectRatio * 1.25,
                      ),
                      controller: controller.loadedImageCount <
                              controller.dataFilter.length
                          ? controller.scrollController
                          : null,
                      itemBuilder: (context, index) {
                        final data = controller.dataFilter[index];
                        if (index == controller.dataFilter.length - 1 &&
                            controller.loadedImageCount <
                                controller.dataFilter.length) {
                          return Column(
                            children: [
                              controller.isLoading.value
                                  ? CircularProgressIndicator()
                                  : SizedBox()
                            ],
                          );
                        } else if (index < controller.dataFilter.length) {
                          return builderItemPengurus(data);
                        } else {
                          return SizedBox();
                        }
                      },
                      itemCount: controller.textController.text != ''
                          ? controller.dataFilter.length
                          : controller.loadedImageCount.value)
                  : Center(
                      child: CircularProgressIndicator(),
                    )),
            ),
            Obx(
              () => controller.isLoading.value
                  ? CircularProgressIndicator()
                  : SizedBox(),
            )
          ],
        ));
  }
}
