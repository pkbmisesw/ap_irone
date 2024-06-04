import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:silahan_kawan/app/data/models/auth/login/users_model.dart';
import 'package:silahan_kawan/app/modules/data_rekap/models/data_rekap_models.dart';
import 'package:silahan_kawan/app/modules/data_rekap/models/model_chart.dart';
import 'package:silahan_kawan/app/modules/data_umum/model/data_umum_models.dart';
import 'package:silahan_kawan/app/modules/data_umum/model/model_chart.dart';
import 'package:silahan_kawan/app/utils/local_db.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DataServices {
  final Dio dio = Dio();
  String? baseUrl = dotenv.env['BASE_URL'];
  UsersModel? data = LocalDb.credential.users;

  Future<List<DataRekapModels>> fetchTableData(
      {bool withoutID = false, bool useIdKec = false}) async {
    final String idParam = useIdKec ? 'id_kec' : 'id_kel';

    final idValue = useIdKec ? data!.idKec : data!.idKel;

    final withID = withoutID ? '' : '&$idParam=$idValue';

    final url =
        '${baseUrl}view-barang-rekap?${withID}&value=data_rekap&order_by=desc';

    print(url);
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)["data"];

        return responseData
            .map((item) => DataRekapModels.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
    }
  }

  Future<List<ModelChartApi>> fetchPieChart(
      {bool withoutID = false, bool useIdKec = false}) async {
    final String idParam = useIdKec ? 'id_kec' : 'id_kel';

    final idValue = useIdKec ? data!.idKec : data!.idKel;

    final withID = withoutID ? '' : '&$idParam=$idValue';

    final url =
        '${baseUrl}view-barang-rekap?${withID}&value=data_rekap&order_by=desc';

    print(url);
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)["data"];

        return responseData
            .map((item) => ModelChartApi.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
    }
  }

  Future<List<DataRekapModels>> fetchPiePerbandinganChart(
      {bool withoutID = false, bool useIdKec = false}) async {
    final String idParam = useIdKec ? 'id_kec' : 'id_kel';

    final idValue = useIdKec ? data!.idKec : data!.idKel;

    final withID = withoutID ? '' : '&$idParam=$idValue';

    final url =
        '${baseUrl}view-barang-rekap?${withID}&value=data_rekap&order_by=desc';

    print(url);
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)["data"];

        return responseData
            .map((item) => DataRekapModels.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
    }
  }

  Future<List<DataRekapModels>> fetchTableDataUmum(
      {bool withoutID = false, bool useIdKec = false}) async {
    final String idParam = useIdKec ? 'id_kec' : 'id_kel';

    final idValue = useIdKec ? data!.idKec : data!.idKel;

    final withID = withoutID ? '' : '&$idParam=$idValue';

    final url =
        '${baseUrl}view-barang-rekap?${withID}&value=data_umum&order_by=desc';

    print(url);
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)["data"];

        return responseData
            .map((item) => DataRekapModels.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
    }
  }

  Future<List<ModelChartApiUmum>> fetchDataUmumPieChart(
      {bool withoutID = false, bool useIdKec = false}) async {
    final String idParam = useIdKec ? 'id_kec' : 'id_kel';

    final idValue = useIdKec ? data!.idKec : data!.idKel;

    final withID = withoutID ? '' : '&$idParam=$idValue';

    final url =
        '${baseUrl}view-barang-rekap?${withID}&value=data_umum&order_by=desc';

    print(url);
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)["data"];

        return responseData
            .map((item) => ModelChartApiUmum.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
    }
  }

  Future<List<DataUmumModel>> fetchDataUmumPiePerbandinganChart(
      {bool withoutID = false, bool useIdKec = false}) async {
    final String idParam = useIdKec ? 'id_kec' : 'id_kel';

    final idValue = useIdKec ? data!.idKec : data!.idKel;

    final withID = withoutID ? '' : '&$idParam=$idValue';

    final url =
        '${baseUrl}view-barang-rekap?${withID}&value=data_umum&order_by=desc';

    print(url);
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)["data"];

        return responseData
            .map((item) => DataUmumModel.fromJson(item))
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
