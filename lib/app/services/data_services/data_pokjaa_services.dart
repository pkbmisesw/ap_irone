import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../../data/models/auth/login/users_model.dart';
import '../../modules/data_pokjaa/models/data_pokja_model.dart';
import '../../modules/data_pokjaa/models/data_pokja_chart_model.dart';
import '../../utils/local_db.dart';

class DataPokjaaServices {
  final Dio dio = Dio();
  String? baseUrl = dotenv.env['BASE_URL'];

  UsersModel? data = LocalDb.credential.users;

  Future<List<DataPokjaModel>> fetchTableData(String value,
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
            .map((item) => DataPokjaModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
    }
  }

  Future<List<ModelChartPokja>> fetchDataPokjaChart(String value) async {
    final url = Uri.parse(
        '${baseUrl}view-barang-rekap?id_kel=${data?.idKel ?? 0}&value=$value&order_by=desc');
    print(url);
    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)["data"];

        return responseData
            .map((item) => ModelChartPokja.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
    }
  }

  Future<List<DataPokjaModel>> fetchDataPokjaChartnew(String value,
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
            .map((item) => DataPokjaModel.fromJson(item))
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
