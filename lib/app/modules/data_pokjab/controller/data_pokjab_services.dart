import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silahan_kawan/app/modules/data_pokjab/models/data_pokjab_model.dart';
import '../../../utils/local_db.dart';
import 'package:http/http.dart' as http;
// ignore: depend_on_referenced_packages
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DataPokjabServices extends ChangeNotifier {
  List<DataPokjabModel> _data = [];
  List<DataPokjabModel> fullData = [];
  bool hasLimitData = false;
  int takeDataList = 10;
  String? baseUrl = dotenv.env['BASE_URL'];

  List<DataPokjabModel> get data => _data;
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
    List<DataPokjabModel> result = [];
    final idKel = LocalDb.credential.users!.idKel;

    final url = Uri.parse(
        '${baseUrl}view-barang-rekap?id_kel=$idKel&value=data_pokjab&order_by=desc');

    try {
      final response = await http.get(url);

      print(url);
      if (response.statusCode == 200) {
        final List<dynamic> lingkunganData = json.decode(response.body)['data'];
        fullData.assignAll(
            lingkunganData.map((e) => DataPokjabModel.fromJson(e)).toList());

        final allItem = lingkunganData.take(takeDataList);
        if (allItem.length == data.length) hasLimitData = true;
        takeDataList += 5;
        for (var item in allItem) {
          result.add(DataPokjabModel.fromJson(item));
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
