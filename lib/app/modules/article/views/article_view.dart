import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:irone/app/data/models/article/item_article_model.dart';
import 'package:irone/app/shared/shared_method.dart';
import 'package:irone/app/shared/shared_theme.dart';
import 'package:irone/app/utils/constants.values.dart';
import 'package:irone/app/utils/constants_endpoints.dart';
import 'package:irone/app/widgets/errors/card_error_item.dart';

import '../controllers/article_controller.dart';

class ArticleView extends GetView<ArticleController> {
  const ArticleView({Key? key}) : super(key: key);

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
                      imageUrl: data != null && data.gambar != null
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

    Widget builderListArticle({List<ItemArticleModel>? data}) {
      return ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) => builderItemArticle(data?[index]),
        separatorBuilder: (context, index) => const SizedBox(height: 18),
        itemCount: data?.length ?? 10,
      );
    }

    return Scaffold(
      appBar: AppBar(
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
      body: FutureBuilder(
        future: controller.getPosting(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.data != null &&
              snapshot.data!.isNotEmpty) {
            return builderListArticle(data: snapshot.data!);
          } else if (snapshot.hasError) {
            return Center(
              child: SizedBox(
                height: size.height / 4,
                child: CardErrorItem(
                  onPressed: () => controller.getPosting(),
                ),
              ),
            );
          }

          return builderListArticle();
        },
      ),
    );
  }
}
