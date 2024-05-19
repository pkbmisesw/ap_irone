import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import '../../data/models/auth/login/users_model.dart';
import '../../modules/data_pokjac/model/data_pokjac_model.dart';
import '../../modules/data_pokjac/model/data_pokjac_chart_model.dart';
import '../../utils/local_db.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DataPokjacServices {
  final Dio dio = Dio();
  String? baseUrl = dotenv.env['BASE_URL'];

  UsersModel? data = LocalDb.credential.users;

  Future<List<DataPokjacModel>> fetchTableData(
      {bool withoutID = false, bool useIdKec = false}) async {
    final String idParam = useIdKec ? 'id_kec' : 'id_kel';

    final idValue = useIdKec ? data!.idKec : data!.idKel;

    final withID = withoutID ? '' : '&$idParam=$idValue';

    final url =
        '${baseUrl}view-barang-rekap?${withID}&value=data_pokjac&order_by=desc';

    try {
      final response = await http.get(Uri.parse(url));

      print("URL: $url");
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)["data"];

        return responseData
            .map((item) => DataPokjacModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
    }
  }

  Future<List<ModelChartPokjac>> fetchDataPokjaChart(
      {bool withoutID = false, bool useIdKec = false}) async {
    final String idParam = useIdKec ? 'id_kec' : 'id_kel';

    final idValue = useIdKec ? data!.idKec : data!.idKel;

    final withID = withoutID ? '' : '&$idParam=$idValue';

    final url =
        '${baseUrl}view-barang-rekap?${withID}&value=data_pokjac&order_by=desc';
    try {
      final response = await http.get(Uri.parse(url));

      print("URL: $url");
      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)["data"];

        return responseData
            .map((item) => ModelChartPokjac.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
    }
  }

  Future<List<DataPokjacModel>> fetchDataPokjaChartnew(String value,
      {bool withoutID = false, bool useIdKec = false}) async {
    final String idParam = useIdKec ? 'id_kec' : 'id_kel';

    final idValue = useIdKec ? data!.idKec : data!.idKel;

    final withID = withoutID ? '' : '&$idParam=$idValue';

    final url =
        '${baseUrl}view-barang-rekap?${withID}&value=data_pokjac&order_by=desc';

    print(url);
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)["data"];

        return responseData
            .map((item) => DataPokjacModel.fromJson(item))
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
