import 'dart:developer';

import 'package:silahan_kawan/app/data/models/auth/login/login_model.dart';
import 'package:silahan_kawan/app/data/models/auth/register/register_model/register_model.dart';
import 'package:silahan_kawan/app/utils/constants_endpoints.dart';

import 'base_dio.dart';

class AuthServices {
  final dio = BaseDio().dio;

  //* LOGIN
  Future<LoginModel> login(Map<String, String> map) async {
    dio.options.baseUrl = ConstantsEndpoints.main;

    return dio.post('/login', data: map).then((value) {
      inspect(value);
      return LoginModel.fromJson(value.data);
    });
  }

  //* REGISTER
  Future<RegisterModel> register(Map<String, String> map) async {
    dio.options.baseUrl = ConstantsEndpoints.main;

    return dio
        .post('/regis', data: map)
        .then((value) => RegisterModel.fromJson(value.data));
  }
}
