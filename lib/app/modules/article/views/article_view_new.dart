import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:silahan_kawan/app/data/models/article/item_article_model.dart';
import 'package:silahan_kawan/app/shared/shared_method.dart';
import 'package:silahan_kawan/app/shared/shared_theme.dart';
import 'package:silahan_kawan/app/utils/constants.values.dart';
import 'package:silahan_kawan/theme.dart';

import '../../../utils/constants_endpoints.dart';
import '../controllers/article_controller.dart';

class ArticleViewNew extends StatefulWidget {
  @override
  _ArticleViewNewState createState() => _ArticleViewNewState();
}

class _ArticleViewNewState extends State<ArticleViewNew> {
  final controller = Get.find<ArticleController>();

  late ScrollController scrollController;
  int loadedImageCount = 5;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoading) {
        loadMoreImages();
      }
    });
  }

  Future<void> loadMoreImages() async {
    isLoading = true;
    setState(() {});
    print('jalan');

    // Delay untuk simulasi proses pengambilan data
    await Future.delayed(Duration(seconds: 2));

    setState(() {
      loadedImageCount += 10;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    Widget builderItemArticle(ItemArticleModel? data) {
      return InkWell(
        key: ValueKey(data?.id),
        onTap: () => controller.moveToArticleDetail(
          id: data?.id.toString() ?? '0',
          itemArticle: data!,
        ),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: SizedBox(
                    width: size.width * 0.3,
                    height: size.height * 0.14,
                    child: CachedNetworkImage(
                      imageUrl: data != null && data.gambar != ''
                          ? '${ConstantsEndpoints.urlImgBanner}${data.gambar}'
                          : 'https://www.toprankindonesia.com/wp-content/uploads/2023/10/4.-Apa-itu-404-not-Found-scaled.jpg',
                      imageBuilder: (context, imageProvider) => Image(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                      progressIndicatorBuilder: (context, url, progress) =>
                          Container(
                        color: theme.colorScheme.surfaceVariant,
                      ),
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/img/no_image.jpg',
                        fit: BoxFit.cover,
                      ).animate().fadeIn(duration: 800.ms),
                    ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        color: (data == null)
                            ? theme.colorScheme.surfaceVariant
                            : null,
                        child: Text(
                          data?.nama ?? ConstantsValues.dummyTitle,
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            fontFamily: SharedTheme.titleTextStyle,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        )
                            .animate(target: (data != null) ? 1 : 0)
                            .visibility(maintain: true),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            color: (data == null)
                                ? theme.colorScheme.surfaceVariant
                                : null,
                            child: Row(
                              children: [
                                const Icon(Icons.schedule_rounded, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  formatTimeAgo(data?.tgl),
                                  style: theme.textTheme.labelLarge,
                                ),
                              ],
                            )
                                .animate(target: (data != null) ? 1 : 0)
                                .visibility(maintain: true),
                          ),
                          const SizedBox(width: 21),
                          Container(
                            color: (data == null)
                                ? theme.colorScheme.surfaceVariant
                                : null,
                            child: Row(
                              children: [
                                const Icon(Icons.visibility_rounded, size: 16),
                                const SizedBox(width: 4),
                                Text(
                                  '${data?.view}',
                                  style: theme.textTheme.labelLarge,
                                ),
                              ],
                            )
                                .animate(target: (data != null) ? 1 : 0)
                                .visibility(maintain: true),
                          ),
                        ],
                      )
                    ],
                  )
                      .animate(
                          onPlay: (controller) => controller.repeat(),
                          target: (data != null) ? 0 : 1)
                      .shimmer(
                        duration: 1800.ms,
                        color: theme.colorScheme.onSurface.withOpacity(0.2),
                      ),
                )
              ],
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgWhite,
        title: const Text(
          'Berita',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        leading: const Icon(
          Icons.arrow_back_ios,
          color: Colors.transparent,
        ),
      ),
      body: Column(
        children: [
          Obx(() => controller.dataValue.isNotEmpty
              ? Expanded(
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 18),
                    controller: loadedImageCount < controller.dataValue.length
                        ? scrollController
                        : null, // Nonaktifkan scroll jika semua gambar telah ditampilkan
                    itemCount: controller.dataValue.length,
                    itemBuilder: (context, index) {
                      final data = controller.dataValue[index];
                      if (index == controller.dataValue.length - 1 &&
                          loadedImageCount < controller.dataValue.length) {
                        return Column(
                          children: [
                            isLoading
                                ? CircularProgressIndicator()
                                : ElevatedButton(
                                    onPressed: loadMoreImages,
                                    child: Text(
                                      'Load More',
                                    ),
                                  ),
                          ],
                        );
                      } else if (index < controller.dataValue.length) {
                        // Menampilkan gambar
                        return builderItemArticle(data);
                      } else {
                        // Placeholder untuk menunjukkan bahwa gambar telah habis
                        return SizedBox();
                      }
                    },
                  ),
                )
              : SizedBox()),
          isLoading ? CircularProgressIndicator() : SizedBox(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }
}
