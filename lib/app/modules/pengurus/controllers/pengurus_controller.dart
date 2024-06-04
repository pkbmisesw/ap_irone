import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';
import 'package:silahan_kawan/app/data/models/pengurus/item_pengurus_model.dart';
import 'package:silahan_kawan/app/modules/init/controllers/init_controller.dart';
import 'package:silahan_kawan/app/services/home_services.dart';

class PengurusController extends GetxController {
  late final InitController initC;
  final HomeServices homeServices = HomeServices();
  final RxBool isSearchMode = false.obs;

  final TextEditingController textController = TextEditingController();
  RxString valueSearch = ''.obs;

  final logger = Logger();

  ScrollController scrollController = ScrollController();
  RxInt loadedImageCount = 10.obs;
  RxBool isLoading = false.obs;
  @override
  void onInit() {
    super.onInit();

    if (Get.isRegistered<InitController>()) {
      initC = Get.find<InitController>();
    }
    fetchData();

    scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
              scrollController.position.maxScrollExtent &&
          !isLoading.value) {
        loadMoreImages();
      }
    });
  }

  Future<void> loadMoreImages() async {
    isLoading.value = true;
    print('jalan');

    // Delay untuk simulasi proses pengambilan data
    await Future.delayed(Duration(seconds: 2));

    loadedImageCount += 10;
    isLoading.value = false;
  }

  Future<List<ItemPengurusModel>> fetchPengurus() async {
    try {
      final resPengurus = await homeServices.getPengurus();

      if (resPengurus.data != null) {
        return resPengurus.data!;
      } else {
        return [];
      }
    } catch (e) {
      logger.e('Error: $e');
      return Future.error(e);
    }
  }

  final RxList<ItemPengurusModel> fullData = <ItemPengurusModel>[].obs;

  final RxList<ItemPengurusModel> dataFilter = <ItemPengurusModel>[].obs;

  void fetchData() async {
    try {
      final value = await fetchPengurus();

      fullData.value = value;
      dataFilter.assignAll(fullData);
      print(value);
    } catch (e) {
      print(e);
    }
  }

  void onSearching() {
    valueSearch.value = textController.text.toLowerCase();

    final filteredData = fullData.where((data) {
      final containsSearch = data.nama!.toLowerCase().contains(valueSearch);

      return containsSearch;
    }).toList();

    dataFilter.assignAll(filteredData);
  }
}
