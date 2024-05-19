import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:irone/app/modules/data_pokjab/models/data_pokjab_model.dart';

class DataPokjabServicesSuper extends ChangeNotifier {
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
    final dio = Dio();

    final rekapApi = '${baseUrl}data-pokjab-view';
    print(rekapApi);
    final response = await dio.get(rekapApi);
    if (response.statusCode == 200) {
      final List<dynamic> lingkunganData = response.data['data'];
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
