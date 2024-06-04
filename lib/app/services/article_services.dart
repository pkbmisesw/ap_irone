import 'package:silahan_kawan/app/data/models/article/article_model.dart';
import 'package:silahan_kawan/app/services/base_dio.dart';
import 'package:silahan_kawan/app/utils/constants_endpoints.dart';

class ArticleServices {
  final dio = BaseDio().dio;

  //* ARTICLE
  Future<ArticleModel> getPosting() {
    dio.options.baseUrl = ConstantsEndpoints.main;

    print(dio.options.baseUrl);
    return dio.get('berita').then((value) => ArticleModel.fromJson(value.data));
  }
}
