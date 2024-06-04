import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:silahan_kawan/app/data/models/article/item_article_model.dart';
import 'package:silahan_kawan/app/routes/app_pages.dart';
import 'package:silahan_kawan/app/services/article_services.dart';

class ArticleController extends GetxController {
  final ArticleServices articleServices = ArticleServices();

  final logger = Logger();
  RxList<ItemArticleModel> dataValue = <ItemArticleModel>[].obs;

  @override
  void onInit() {
    getPostingData();
    super.onInit();
  }

  RxBool isLoading = false.obs;

  void getPostingData() async {
    final data = await getPosting();
    dataValue.value = data;
    isLoading.value = false;
    print(isLoading);
  }

  Future<List<ItemArticleModel>> getPosting() async {
    isLoading.value = true;
    try {
      final resPosting = await articleServices.getPosting();

      if (resPosting.data != null) {
        List<ItemArticleModel> dataFilter =
            await compute(filterNews, resPosting.data!);

        print('data ada');

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

  void moveToArticleDetail({
    required String id,
    required ItemArticleModel itemArticle,
  }) =>
      Get.toNamed(
        '${Routes.ARTICLE}/$id',
        arguments: itemArticle,
      );
}
