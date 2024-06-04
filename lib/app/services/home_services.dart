import 'dart:convert';

import 'package:silahan_kawan/app/data/models/banner/banner_model.dart';
import 'package:silahan_kawan/app/data/models/pengurus/pengurus_model.dart';
import 'package:silahan_kawan/app/utils/constants_endpoints.dart';
import 'package:http/http.dart' as http;
import 'base_dio.dart';

class HomeServices {
  final dio = BaseDio().dio;

  //* BANNER SLIDER
  Future<BannerModel> getBanner() {
    dio.options.baseUrl = ConstantsEndpoints.main;

    return dio
        .get('iklan-banner')
        .then((value) => BannerModel.fromJson(value.data));
  }

  //* PENGURUS
  Future<PengurusModel> getPengurus() async {
    final response =
        await http.get(Uri.parse('${ConstantsEndpoints.main}pengurus'));
    print(response.statusCode);

    if (response.statusCode == 200) {
      return PengurusModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Gagal memuat data pengurus');
    }
  }
}
