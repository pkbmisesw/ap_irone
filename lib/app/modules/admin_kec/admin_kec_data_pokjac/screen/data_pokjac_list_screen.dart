import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:silahan_kawan/app/modules/data_pokjaa/widget/data_pokja_list_widget.dart';
import 'package:silahan_kawan/app/modules/data_pokjac/model/data_pokjac_model.dart';
import 'package:silahan_kawan/app/modules/data_pokjac/screen/data_pokjac_detail_screen.dart';
import 'package:silahan_kawan/theme.dart';
import 'package:remixicon/remixicon.dart';
import 'package:get/get.dart';

import '../controller/data_pokjac_services.dart';
import 'data_pokjac_detail_screen.dart';

class AdminKecDataPokjacListScreen extends StatefulWidget {
  const AdminKecDataPokjacListScreen({super.key});

  @override
  State<AdminKecDataPokjacListScreen> createState() =>
      _AdminKecDataPokjacListScreenState();
}

class _AdminKecDataPokjacListScreenState
    extends State<AdminKecDataPokjacListScreen> {
  final AdminKecDataPokjacServices services = AdminKecDataPokjacServices();
  final RxList<DataPokjacModel> fullData = <DataPokjacModel>[].obs;

  final RxList<DataPokjacModel> dataFilter = <DataPokjacModel>[].obs;
  RxString valueSearch = ''.obs;

  void onSearching() {
    valueSearch.value = textController.text.toLowerCase();

    final filteredData = fullData.where((data) {
      final containsSearch = data.ket!.toLowerCase().contains(valueSearch);
      final matchesId = data.id.toString().toLowerCase().contains(valueSearch);
      final matchesIdKec =
          data.idKec.toString().toLowerCase().contains(valueSearch);
      final matchesIdKel =
          data.idKel.toString().toLowerCase().contains(valueSearch);
      final matchesNamaLing =
          data.namaLing.toString().toLowerCase().contains(valueSearch);

      return containsSearch ||
          matchesId ||
          matchesIdKec ||
          matchesIdKel ||
          matchesNamaLing;
    }).toList();

    dataFilter.assignAll(filteredData);
  }

  @override
  void initState() {
    fetchData();
    super.initState();
    services.onInit();
  }

  void fetchData() async {
    try {
      final value = await services.fetchData();
      if (value) {
        fullData.assignAll(services.fullData);
      } else {}
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    services.onDispose();
    super.dispose();
  }

  final TextEditingController textController = TextEditingController();
  final RxBool isSearchMode = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: bgWhite,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: Icon(
              Remix.arrow_left_line,
              color: Color(0xffB00020),
            ),
          ),
          title: Obx(
            () => isSearchMode.value
                ? TextField(
                    controller: textController,
                    onChanged: (value) {
                      onSearching();
                    },
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      hintStyle: TextStyle(color: Colors.black),
                    ),
                    style: TextStyle(color: Colors.black),
                  )
                : Text('Data Pokja 3 Lingkungan',
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Color(0xffB00020),
                    )),
          ),
          actions: [
            IconButton(
              icon: Obx(
                () => Icon(
                  isSearchMode.value ? Icons.close : Icons.search,
                  color: bgRed,
                ),
              ),
              onPressed: () {
                isSearchMode.toggle();
                if (!isSearchMode.value) {
                  textController.clear();
                }
                valueSearch.value = '';
              },
            ),
          ],
        ),
        body: Obx(() => valueSearch.value == ''
            ? ListenableBuilder(
                listenable: services,
                builder: (BuildContext context, Widget? child) => ListView(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  controller: services.scrollDataCTRL,
                  children: [
                    ...List.generate(
                      services.data.length + 1,
                      (index) {
                        if (index < services.data.length) {
                          return DataPokjaListWidget(
                            id: services.data[index].id.toString(),
                            idKec:
                                services.data[index].kecamatan_nama.toString(),
                            idKel:
                                services.data[index].kelurahan_nama.toString(),
                            namaLing: services.data[index].namaLing,
                            ket: services.data[index].ket ?? '',
                            fuctionMore: () {
                              showModalBottomSheet(
                                context: Get.overlayContext!,
                                isScrollControlled: true,
                                builder: (context) {
                                  return ShowModalBodyListPokja(
                                    function1: () {
                                      Get.to(
                                          () => AdminKecDataPokjacDetailScreen(
                                                data: services.data[index],
                                              ));
                                    },
                                    function2: () {},
                                    detailData: 'Detail Data',
                                    isDeleteAdd: true,
                                  );
                                },
                              );
                            },
                          );
                        } else if (services.data.isEmpty &&
                            services.hasLimitData) {
                          return const Center(child: Text('Kosong'));
                        } else {
                          return Visibility(
                            visible: services.hasLimitData,
                            replacement: GestureDetector(
                              onTap: services.onStoryReload,
                              child: const Icon(Icons.refresh),
                            ),
                            child: GestureDetector(
                              onTap: services.onStoryReload,
                              child: const Icon(Icons.refresh),
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              )
            : ListView.builder(
                itemCount: dataFilter.length,
                itemBuilder: (context, index) {
                  final data = dataFilter[index];
                  return DataPokjaListWidget(
                    id: data.id.toString(),
                    idKec: data.kecamatan_nama.toString(),
                    idKel: data.kelurahan_nama.toString(),
                    namaLing: data.namaLing,
                    ket: data.ket ?? '',
                    fuctionMore: () {
                      showModalBottomSheet(
                        context: Get.overlayContext!,
                        isScrollControlled: true,
                        builder: (context) {
                          return ShowModalBodyListPokja(
                            function1: () {
                              Get.to(() => AdminKecDataPokjacDetailScreen(
                                    data: data,
                                  ));
                            },
                            function2: () {},
                            detailData: 'Detail Data',
                            isDeleteAdd: true,
                          );
                        },
                      );
                    },
                  );
                },
              )));
  }
}
