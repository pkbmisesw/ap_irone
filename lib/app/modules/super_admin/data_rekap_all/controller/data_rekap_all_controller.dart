import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../model/data_rekap_all_model.dart';

class DataRekapAllController extends GetxController {
  // final kecamatanList = RxList<Kecamatan>();
  // final RxBool isLoading = true.obs;

  // Future<void> fetchDataFromApi() async {
  //   try {
  //     final response = await http
  //         .get(Uri.parse('https://app2.tppkk-bitung.com/api/kecamatan'));
  //     if (response.statusCode == 200) {
  //       final jsonData = json.decode(response.body);
  //       final List<dynamic> data = jsonData['data'];
  //       kecamatanList.clear();
  //       data.forEach((kecamatan) {
  //         kecamatanList.add(Kecamatan.fromJson(kecamatan));
  //       });
  //       print('hehe');
  //     } else {
  //       throw Exception('Failed to load data');
  //     }

  //     isLoading.value = false;
  //   } catch (e) {
  //     throw Exception('Error: $e');
  //   }
  // }
  final dataTable = RxList<DataTabel>();
  // var dataTable = <DataTabel>[].obs;
  RxBool isLoading = true.obs;

  void fetchData() async {
    try {
      isLoading(true);
      var response = await http
          .get(Uri.parse('https://app2.tppkk-bitung.com/api/data-rekap'));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var data = jsonResponse['data']['data_tabel'] as List;
        dataTable.value = data.map((e) => DataTabel.fromJson(e)).toList();
        print(dataTable.map((element) => element.jumlahKecamatan));
        update();
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      isLoading(false);
    }
  }
}
