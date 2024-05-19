import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irone/app/modules/data_pokjaa/models/data_pokja_model.dart';
import 'package:irone/app/utils/local_db.dart';

import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AdminKecDataPokjaaServices extends ChangeNotifier {
  List<DataPokjaModel> _data = [];
  List<DataPokjaModel> fullData = [];
  bool hasLimitData = false;
  int takeDataList = 10;
  String? baseUrl = dotenv.env['BASE_URL'];

  List<DataPokjaModel> get data => _data;
  final scrollDataCTRL = ScrollController();

  void onInit() {
    scrollDataCTRL.addListener(() {
      if (scrollDataCTRL.position.maxScrollExtent == scrollDataCTRL.offset) {
        fetchData();
      }
    });
  }

  void onDispose() {
    scrollDataCTRL.dispose();
  }

  // Get Data
  Future<bool> fetchData() async {
    List<DataPokjaModel> result = [];
    final idKec = LocalDb.credential.users!.idKec;

    final url = Uri.parse(
        '${baseUrl}view-barang-rekap?id_kec=$idKec&value=data_pokjaa&order_by=desc');
    try {
      final response = await http.get(url);

      print(url);
      if (response.statusCode == 200) {
        final List<dynamic> lingkunganData = json.decode(response.body)['data'];
        fullData.assignAll(
            lingkunganData.map((e) => DataPokjaModel.fromJson(e)).toList());

        final allItem = lingkunganData.take(takeDataList);
        if (allItem.length == data.length) hasLimitData = true;
        takeDataList += 5;
        for (var item in allItem) {
          result.add(DataPokjaModel.fromJson(item));
        }
        _data = result;
        notifyListeners();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error fetching data: $e");
      return false;
    }
  }

  Future<void> onStoryReload() async {
    _data.clear();
    hasLimitData = false;
    takeDataList = 10;
    await fetchData();
    scrollDataCTRL.position.moveTo(
      1,
      duration: const Duration(milliseconds: 600),
      curve: Curves.easeInSine,
    );
  }
}
