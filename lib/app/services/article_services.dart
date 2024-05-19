import 'package:irone/app/data/models/article/article_model.dart';
import 'package:irone/app/services/base_dio.dart';
import 'package:irone/app/utils/constants_endpoints.dart';

class ArticleServices {
  final dio = BaseDio().dio;

  //* ARTICLE
  Future<ArticleModel> getPosting() {
    dio.options.baseUrl = ConstantsEndpoints.main;

    return dio.get('berita').then((value) => ArticleModel.fromJson(value.data));
  }
}
