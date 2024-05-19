import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irone/app/modules/data_rekap/widget/bottomsheet.dart';
import 'package:irone/app/modules/home/views/appbar.dart';
import 'package:irone/app/modules/super_admin/data_rekap_all/controller/data_rekap_all_controller.dart';
import 'package:irone/theme.dart';
import 'package:remixicon/remixicon.dart';

import 'data_rekap_all_barchart.dart';
import 'data_rekap_all_kecamatan.dart';
import 'data_rekap_all_piechart_kecamatan.dart';

class DataRekapAll extends StatefulWidget {
  const DataRekapAll({super.key});

  @override
  State<DataRekapAll> createState() => _DataRekapAllState();
}

class _DataRekapAllState extends State<DataRekapAll> {
  final controller = Get.put(DataRekapAllController());

  @override
  void initState() {
    super.initState();
    controller.fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const AppBarUniversal(title: 'Data Sim TP PKK BITUNG'),
        body: Obx(
          () => controller.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Obx(() {
                      final data = controller.dataTable[index];
                      return Padding(
                        padding: const EdgeInsetsDirectional.symmetric(
                            vertical: 10, horizontal: 16),
                        child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: bgWhite,
                                border:
                                    Border.all(color: const Color(0xffF2F2F2))),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Kecamatan : ${data.namaKec}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: trueBlack,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      const Divider(),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: bgWhite,
                                                border: const Border(
                                                  right: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    'Kelurahan',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    data.jumlahKecamatan
                                                        .toString(),
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: bgWhite,
                                                border: const Border(
                                                  right: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    'RW',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    '${data.jumlahRw}',
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: bgWhite,
                                                border: const Border(
                                                  right: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    'RT',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    '${data.jumlahRt}',
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: bgWhite,
                                              ),
                                              child: Column(
                                                children: [
                                                  const Text(
                                                    'KK',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    '${data.jumlahKk}',
                                                    style: const TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w400),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                InkWell(
                                    onTap: () {
                                      showModalBottomSheet(
                                        context: Get.overlayContext!,
                                        isScrollControlled: true,
                                        builder: (context) {
                                          return DataRekapAllShowmodal(
                                            function1: () {
                                              Get.to(
                                                  () => DataRekapAllKecamatan(
                                                        title: data.namaKec,
                                                        idKec: data.idKec,
                                                      ));
                                            },
                                            function2: () {
                                              Get.to(() =>
                                                  DataRekapAllPieKecamatan(
                                                    title: data.namaKec,
                                                    idKec: data.idKec,
                                                  ));
                                            },
                                            function3: () {
                                              Get.to(() =>
                                                  DataRekapAllBarKecamatan(
                                                    title: data.namaKec,
                                                    idKec: data.idKec,
                                                  ));
                                            },
                                          );
                                        },
                                      );
                                    },
                                    child: const Icon(Remix.more_2_fill))
                              ],
                            )),
                      );
                    });
                  },
                  itemCount: controller.dataTable.length,
                ),
        ));
  }
}

class DataRekapAllShowmodal extends StatelessWidget {
  DataRekapAllShowmodal(
      {super.key,
      required this.function1,
      required this.function2,
      required this.function3,
      this.isDeleteAdd = false});
  final void Function() function1;
  final void Function() function2;
  final void Function() function3;
  final bool isDeleteAdd;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12,
        horizontal: 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 12,
          ),
          BottomSheetAction(
            title: 'Lihat Detail Kecamatan',
            icon: Remix.home_line,
            iconColor: bgBlue,
            onTap: () {
              Get.back();
              function1();
            },
          ),
          BottomSheetAction(
            title: 'Lihat Dalam Pie Chart Data',
            icon: Remix.pie_chart_2_line,
            iconColor: bgBlue,
            onTap: () {
              Get.back();
              function2();
            },
          ),
        ],
      ),
    );
  }
}
