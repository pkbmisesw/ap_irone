import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:silahan_kawan/app/modules/data_rekap/models/data_rekap_models.dart';
import 'package:silahan_kawan/app/modules/data_rekap/widget/bottomsheet.dart';
import 'package:silahan_kawan/theme.dart';
import 'package:remixicon/remixicon.dart';

import '../controllers/data_rekap_services.dart';
import 'data_rekap_screen_new.dart';
import 'package:get/get.dart';
// *STANDART CODE*

class AdminKecDataRekapScreen extends StatefulWidget {
  const AdminKecDataRekapScreen({super.key});

  @override
  State<AdminKecDataRekapScreen> createState() =>
      _AdminKecDataRekapScreenState();
}

class _AdminKecDataRekapScreenState extends State<AdminKecDataRekapScreen> {
  final AdminKecDataRekapServicesX services = AdminKecDataRekapServicesX();
  final RxList<DataRekapModels> fullData = <DataRekapModels>[].obs;

  final RxList<DataRekapModels> dataFilter = <DataRekapModels>[].obs;
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
                : Text('Data Rekap Lingkungan',
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
                          return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: InkWell(
                              onTap: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //     builder: (context) => DataDetailsRekapScreen(
                                //       data: services.data[index],
                                //     ),
                                //   ),
                                // );
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 6),
                                decoration: ShapeDecoration(
                                  color: bgRed,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  shadows: [
                                    BoxShadow(
                                      color: Color(0x3F000000),
                                      blurRadius: 4,
                                      offset: Offset(0, 4),
                                      spreadRadius: 0,
                                    )
                                  ],
                                ),
                                child: Container(
                                  color: bgWhite,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            _bodyValue('Nama Kecamatan',
                                                '${services.data[index].kecamatan_nama}'),
                                            _bodyValue('Nama Kelurahan',
                                                '${services.data[index].kelurahan_nama}'),
                                            _bodyValue('Nama Lingkungan',
                                                '${services.data[index].namaLing}'),
                                            Divider(),
                                            RichText(
                                              text: TextSpan(
                                                text: 'Keterangan :   ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: basicBlack),
                                                children: <TextSpan>[
                                                  TextSpan(
                                                    text:
                                                        '${services.data[index].ket}',
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      fontSize: 14,
                                                      color: basicBlack,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: InkWell(
                                          onTap: () {
                                            showModalBottomSheet(
                                              context: Get.overlayContext!,
                                              isScrollControlled: true,
                                              builder: (context) {
                                                return _modalBottom(
                                                  () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            AdminKecDataRekapScreenNew(
                                                          data: services
                                                              .data[index],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                );
                                              },
                                            );
                                          },
                                          child: Icon(
                                            Remix.more_2_fill,
                                            color: bgRed,
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
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
                  return Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Container(
                      padding: EdgeInsets.only(left: 6),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        shadows: [
                          BoxShadow(
                            color: Color(0x3F000000),
                            blurRadius: 4,
                            offset: Offset(0, 4),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: Container(
                        color: bgWhite,
                        padding:
                            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  _bodyValue('Nama Kecamatan',
                                      '${data.kecamatan_nama}'),
                                  _bodyValue('Nama Kelurahan',
                                      '${data.kelurahan_nama}'),
                                  _bodyValue(
                                      'Nama Lingkungan', '${data.namaLing}'),
                                  Divider(),
                                  RichText(
                                    text: TextSpan(
                                      text: 'Keterangan :   ',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: basicBlack),
                                      children: <TextSpan>[
                                        TextSpan(
                                          text: '${data.ket}',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14,
                                            color: basicBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: Get.overlayContext!,
                                    isScrollControlled: true,
                                    builder: (context) {
                                      return _modalBottom(
                                        () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  AdminKecDataRekapScreenNew(
                                                data: data,
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                },
                                child: Icon(
                                  Remix.more_2_fill,
                                  color: bgRed,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                },
              )));
  }

  Widget _modalBottom(
    void Function() function1,
  ) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            height: 12,
          ),
          BottomSheetAction(
            title: 'Detail Data',
            icon: Remix.pencil_line,
            iconColor: bgBlue,
            onTap: () {
              Get.back();
              function1();
            },
          ),
        ],
      ),
    );
  }

  Widget _bodyValue(
    String title,
    String value,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
            flex: 1,
            child: SizedBox(
                width: double.infinity,
                child: Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    color: basicBlack,
                  ),
                ))),
        Flexible(
            flex: 1,
            child: SizedBox(
                width: double.infinity,
                child: Text(
                  ': $value',
                  style: GoogleFonts.poppins(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: basicBlack,
                  ),
                ))),
      ],
    );
  }

  void deleteItem(int index) {
    // Menampilkan pemberitahuan bahwa item dianggap berhasil dihapus
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data Berhasil di Hapus'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}
