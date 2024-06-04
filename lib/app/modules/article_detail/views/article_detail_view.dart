import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:silahan_kawan/app/data/models/article/item_article_model.dart';
import 'package:silahan_kawan/app/modules/article_detail/controllers/article_detail_controller.dart';
import 'package:silahan_kawan/app/shared/cards.dart';
import 'package:silahan_kawan/app/shared/shared_method.dart';
import 'package:silahan_kawan/app/shared/shared_theme.dart';
import 'package:silahan_kawan/app/utils/constants_endpoints.dart';

class ArticleDetailView extends GetView<ArticleDetailController> {
  const ArticleDetailView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    // final id = Get.parameters['id'];
    final data = Get.arguments as ItemArticleModel?;

    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height / 2.5,
            child: CachedNetworkImage(
              imageUrl: '${ConstantsEndpoints.urlImgBanner}${data?.gambar}',
              imageBuilder: (context, imageProvider) => Image(
                image: imageProvider,
                fit: BoxFit.fill,
              ),
              progressIndicatorBuilder: (context, url, progress) => Container(
                color: theme.colorScheme.surfaceVariant,
              ),
              errorWidget: (context, url, error) {
                return Image.asset(
                  'assets/img/no_image.jpg',
                  fit: BoxFit.cover,
                ).animate().fadeIn(duration: 800.ms);
              },
            ),
          ),
          Positioned.fill(
            top: size.height / 3,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(32),
                  topRight: Radius.circular(32),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Cards.filled(
                          context: context,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Opacity(
                                  opacity: 0.5,
                                  child: Icon(
                                    Icons.edit_rounded,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  data?.penulis ?? '-',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Cards.filled(
                          context: context,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Opacity(
                                  opacity: 0.5,
                                  child: Icon(
                                    Icons.schedule_rounded,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  formatTimeAgo(data?.tgl),
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Cards.filled(
                          context: context,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                const Opacity(
                                  opacity: 0.5,
                                  child: Icon(
                                    Icons.visibility_rounded,
                                    size: 16,
                                  ),
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${data?.view}',
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    AutoSizeText(
                      '${data?.nama?.trim()}',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        fontFamily: SharedTheme.titleTextStyle,
                      ),
                      maxFontSize: 21,
                    ),
                    const SizedBox(height: 6),
                    Opacity(
                      opacity: 0.7,
                      child: Text(
                        formatedDateToString(
                          oldPattern: 'dd-MM-yyyy HH:mm:ss a',
                          newPattern: DateFormat.YEAR_MONTH_WEEKDAY_DAY,
                          value: data?.tgl,
                        ),
                        style: theme.textTheme.labelMedium,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      removeAllHtmlTags(data?.des ?? ''),
                      style: theme.textTheme.bodyMedium,
                      textAlign: TextAlign.justify,
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            top: 38,
            left: 14,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: theme.colorScheme.surface.withOpacity(0.3),
              ),
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_ios_new_rounded,
                  size: 21,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
