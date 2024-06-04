import 'package:silahan_kawan/app/data/models/profile/profile_model.dart';
import 'package:silahan_kawan/app/services/base_dio.dart';
import 'package:silahan_kawan/app/utils/constants_endpoints.dart';

class ProfileServices {
  final dio = BaseDio().dio;

  //* PROFILE
  Future<ProfileModel> getProfile() {
    dio.options.baseUrl = ConstantsEndpoints.main;

    return dio.get('info').then((value) => ProfileModel.fromJson(value.data));
  }
}
