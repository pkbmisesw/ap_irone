import 'package:silahan_kawan/app/data/models/law/law_model.dart';
import 'package:silahan_kawan/app/services/base_dio.dart';
import 'package:silahan_kawan/app/utils/constants_endpoints.dart';

class LawServices {
  final dio = BaseDio().dio;

  //* LAW
  Future<LawModel> getLaw() {
    dio.options.baseUrl = ConstantsEndpoints.main;

    return dio.get('hukum').then((value) => LawModel.fromJson(value.data));
  }
}
