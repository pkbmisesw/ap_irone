import 'package:irone/app/data/models/profile/profile_model.dart';
import 'package:irone/app/services/base_dio.dart';
import 'package:irone/app/utils/constants_endpoints.dart';

class ProfileServices {
  final dio = BaseDio().dio;

  //* PROFILE
  Future<ProfileModel> getProfile() {
    dio.options.baseUrl = ConstantsEndpoints.main;

    return dio.get('info').then((value) => ProfileModel.fromJson(value.data));
  }
}
