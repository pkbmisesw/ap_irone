import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../../data/models/auth/login/users_model.dart';
import '../../modules/data_pokjad/model/data_pokjad_model.dart';
import '../../modules/data_pokjad/model/data_pokjad_chart_model.dart';
import '../../utils/local_db.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DataPokjadServices {
  final Dio dio = Dio();
  String? baseUrl = dotenv.env['BASE_URL'];

  UsersModel? data = LocalDb.credential.users;

  Future<List<DataPokjadModel>> fetchTableData(
      {bool withoutID = false, bool useIdKec = false}) async {
    final String idParam = useIdKec ? 'id_kec' : 'id_kel';

    final idValue = useIdKec ? data!.idKec : data!.idKel;

    final withID = withoutID ? '' : '&$idParam=$idValue';

    final url =
        '${baseUrl}view-barang-rekap?${withID}&value=data_pokjad&order_by=desc';
    print(url);
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)["data"];

        return responseData
            .map((item) => DataPokjadModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
    }
  }

  Future<List<ModelChartPokjad>> fetchDataPokjaChart() async {
    final url = Uri.parse(
        '${baseUrl}view-barang-rekap?id_kel=${data?.idKel ?? 0}&value=pokjad&order_by=desc');

    try {
      final response = await http.get(url);

      print("URL: $url");
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)["data"];

        return responseData
            .map((item) => ModelChartPokjad.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
    }
  }

  Future<List<DataPokjadModel>> fetchDataPokjaChartnew(String value,
      {bool withoutID = false, bool useIdKec = false}) async {
    final String idParam = useIdKec ? 'id_kec' : 'id_kel';

    final idValue = useIdKec ? data!.idKec : data!.idKel;

    final withID = withoutID ? '' : '&$idParam=$idValue';

    final url =
        '${baseUrl}view-barang-rekap?${withID}&value=$value&order_by=desc';

    print(url);
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)["data"];

        return responseData
            .map((item) => DataPokjadModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
    }
  }
}
