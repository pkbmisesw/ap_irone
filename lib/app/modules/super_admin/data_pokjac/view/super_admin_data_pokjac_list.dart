import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irone/app/modules/data_pokjac/model/data_pokjac_model.dart';
import 'package:irone/theme.dart';
import 'package:remixicon/remixicon.dart';
import 'package:get/get.dart';

import '../../../data_pokjaa/widget/data_pokja_list_widget.dart';
import '../controller/super_admin_data_pokjab_services.dart';
import 'super_admin_data_pokjac_detail.dart';

class SuperDataPokjacListScreen extends StatefulWidget {
  const SuperDataPokjacListScreen({super.key});

  @override
  State<SuperDataPokjacListScreen> createState() =>
      _SuperDataPokjacListScreenState();
}

class _SuperDataPokjacListScreenState extends State<SuperDataPokjacListScreen> {
  final DataPokjacServicesSuper services = DataPokjacServicesSuper();
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
                            useName: true,
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
                                    isDeleteAdd: true,
                                    function1: () {
                                      Get.to(
                                          () => SuperAdminDataPokjacViewScreen(
                                                data: services.data[index],
                                              ));
                                    },
                                    function2: () {},
                                    detailData: 'Detail Data',
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
                    useName: true,
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
                            isDeleteAdd: true,
                            function1: () {
                              Get.to(() => SuperAdminDataPokjacViewScreen(
                                    data: data,
                                  ));
                            },
                            function2: () {},
                            detailData: 'Detail Data',
                          );
                        },
                      );
                    },
                  );
                },
              )));
  }
}
