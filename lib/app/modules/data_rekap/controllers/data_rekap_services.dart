import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../utils/local_db.dart';
import '../models/data_rekap_models.dart';

class DataRekapServicesX extends ChangeNotifier {
  List<DataRekapModels> _data = [];
  List<DataRekapModels> fullData = [];
  bool hasLimitData = false;
  int takeDataList = 10;

  List<DataRekapModels> get data => _data;
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
    List<DataRekapModels> result = [];
    final idKel = LocalDb.credential.users!.idKel;
    final dio = Dio();
    final rekapApi =
        'http://app2.tppkk-bitung.com/api/view-barang-rekap?id_kel=$idKel';

    final response = await dio.get(rekapApi);
    print(rekapApi);
    if (response.statusCode == 200) {
      final List<dynamic> lingkunganData = response.data['data'];
      fullData.assignAll(
          lingkunganData.map((e) => DataRekapModels.fromJson(e)).toList());

      final allItem = lingkunganData.take(takeDataList);
      if (allItem.length == data.length) hasLimitData = true;
      takeDataList += 5;
      for (var item in allItem) {
        result.add(DataRekapModels.fromJson(item));
      }
      _data = result;
      notifyListeners();
      return true;
    } else {
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
