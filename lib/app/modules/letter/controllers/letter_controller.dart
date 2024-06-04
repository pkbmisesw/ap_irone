import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:silahan_kawan/app/data/models/letter/item_letter_model.dart';
import 'package:silahan_kawan/app/routes/app_pages.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:silahan_kawan/app/services/letter_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class LetterController extends GetxController {
  late final LetterServices _letterServices;

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();

    fetchData();
    _letterServices = LetterServices();
  }

  String? baseUrl = dotenv.env['BASE_URL'];

  RxList<ItemLetterModel> fullData = <ItemLetterModel>[].obs;

  RxList<ItemLetterModel> dataFilter = <ItemLetterModel>[].obs;

  final typeLetter = Get.arguments as int;

  RxString valueSearch = ''.obs;
  final RxBool isSearchMode = false.obs;
  final TextEditingController textController = TextEditingController();

  void onSearching() {
    valueSearch.value = textController.text.toLowerCase();

    final filteredData = fullData.where((data) {
      final containsSearch = data.nama!.toLowerCase().contains(valueSearch);

      return containsSearch;
    }).toList();

    dataFilter.assignAll(filteredData);
  }

  // Get Data
  Future<bool> fetchData() async {
    final String typeData = typeLetter == 1 ? 'suratmasuk' : 'suratkeluar';
    final url = Uri.parse('$baseUrl$typeData');

    try {
      final response = await http.get(url);

      print(url);
      if (response.statusCode == 200) {
        final List<dynamic> lingkunganData = json.decode(response.body)['data'];
        final value =
            lingkunganData.map((e) => ItemLetterModel.fromJson(e)).toList();

        fullData.value = value;
        dataFilter.assignAll(value);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error fetching data: $e");
      return false;
    }
  }

  Future<List<ItemLetterModel>> getIncomingLetter() async {
    try {
      final resLetter = await _letterServices.getIncomingLetter();

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

  Future<List<ItemLetterModel>> getOutgoingLetter() async {
    try {
      final resLetter = await _letterServices.getOutgoingLetter();

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

  void moveToDetailLetter({
    required String id,
    required String urlPDF,
  }) =>
      Get.toNamed(
        '${Routes.LAW}/$id',
        arguments: urlPDF,
      );
}
