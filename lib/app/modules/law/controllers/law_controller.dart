import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:silahan_kawan/app/data/models/law/item_law_model.dart';
import 'package:silahan_kawan/app/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:silahan_kawan/app/services/law_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class LawController extends ChangeNotifier {
  late final LawServices _lawServices;

  final logger = Logger();

  final scrollDataCTRL = ScrollController();

  void onInit() {
    scrollDataCTRL.addListener(() {
      if (scrollDataCTRL.position.maxScrollExtent == scrollDataCTRL.offset) {
        fetchData();
      }
    });
  }

  String? baseUrl = dotenv.env['BASE_URL'];

  List<ItemLawModel> _data = [];
  List<ItemLawModel> fullData = [];
  bool hasLimitData = false;
  int takeDataList = 10;

  List<ItemLawModel> get data => _data;

  Future<bool> fetchData() async {
    List<ItemLawModel> result = [];

    final url = Uri.parse('${baseUrl}hukum');

    try {
      final response = await http.get(url);

      print(url);
      if (response.statusCode == 200) {
        final List<dynamic> lingkunganData = json.decode(response.body)['data'];
        fullData.assignAll(
            lingkunganData.map((e) => ItemLawModel.fromJson(e)).toList());

        final allItem = lingkunganData.take(takeDataList);
        if (allItem.length == data.length) hasLimitData = true;
        takeDataList += 5;
        for (var item in allItem) {
          result.add(ItemLawModel.fromJson(item));
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

  Future<List<ItemLawModel>> getLaw() async {
    try {
      final resLetter = await _lawServices.getLaw();

      if (resLetter.data != null) {
        return resLetter.data!;
      }
    } on DioException catch (e) {
      logger.e('Error: $e');
      logger.e('Error Type: ${e.type}');
      return Future.error(e);
    }

    return [];
  }

  void moveToDetailLaw({
    required String id,
    required String urlPDF,
  }) =>
      Get.toNamed(
        '${Routes.LETTER}/$id',
        arguments: urlPDF,
      );

  void onDispose() {}
}
