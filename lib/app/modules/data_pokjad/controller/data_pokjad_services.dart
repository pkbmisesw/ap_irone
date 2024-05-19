import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/local_db.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../model/data_pokjad_model.dart';

class DataPokjadServices extends ChangeNotifier {
  List<DataPokjadModel> _data = [];
  List<DataPokjadModel> fullData = [];
  bool hasLimitData = false;
  int takeDataList = 10;
  String? baseUrl = dotenv.env['BASE_URL'];

  List<DataPokjadModel> get data => _data;
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
    List<DataPokjadModel> result = [];
    final idKel = LocalDb.credential.users!.idKel;

    final url = Uri.parse(
        '${baseUrl}view-barang-rekap?id_kel=$idKel&value=data_pokjad&order_by=desc');

    try {
      final response = await http.get(url);

      print(url);
      if (response.statusCode == 200) {
        final List<dynamic> lingkunganData = json.decode(response.body)['data'];
        fullData.assignAll(
            lingkunganData.map((e) => DataPokjadModel.fromJson(e)).toList());

        final allItem = lingkunganData.take(takeDataList);
        if (allItem.length == data.length) hasLimitData = true;
        takeDataList += 5;
        for (var item in allItem) {
          result.add(DataPokjadModel.fromJson(item));
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
