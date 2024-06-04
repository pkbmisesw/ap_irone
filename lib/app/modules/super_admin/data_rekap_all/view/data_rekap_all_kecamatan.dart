import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silahan_kawan/app/modules/data_rekap/widget/bottomsheet.dart';
import 'package:silahan_kawan/app/modules/home/views/appbar.dart';
import 'package:http/http.dart' as http;
import 'package:silahan_kawan/theme.dart';
import 'package:remixicon/remixicon.dart';
import '../model/data_rekap_all_kecamatan_model.dart';
import 'data_rekap_all_kelurahan_piechart.dart';

class DataRekapAllKecamatan extends StatefulWidget {
  DataRekapAllKecamatan({required this.title, required this.idKec});
  final String title;
  final int idKec;

  @override
  State<DataRekapAllKecamatan> createState() => _DataRekapAllKecamatanState();
}

class _DataRekapAllKecamatanState extends State<DataRekapAllKecamatan> {
  RxBool isLoading = true.obs;
  final dataTable = RxList<DataRekapAllDataTabel>();

  void fetchData() async {
    try {
      isLoading(true);
      var response = await http.get(Uri.parse(
          'https://app2.tppkk-bitung.com/api/data-rekap-kecamatan/${widget.idKec}'));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var data = jsonResponse['data']['data_tabel'] as List;
        dataTable.value =
            data.map((e) => DataRekapAllDataTabel.fromJson(e)).toList();
        print(dataTable.map((element) => element.jumlahKk));
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    } catch (error) {
      print('Error: $error');
    } finally {
      isLoading(false);
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBarUniversal(title: 'Data Sim Kecamatan ${widget.title}'),
        body: Obx(
          () => isLoading.value
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.builder(
                  itemBuilder: (context, index) {
                    return Obx(() {
                      final data = dataTable[index];
                      return Padding(
                        padding: EdgeInsetsDirectional.symmetric(
                            vertical: 10, horizontal: 16),
                        child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                                color: bgWhite,
                                border: Border.all(color: Color(0xffF2F2F2))),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Kelurahan : ${data.namaKel}',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: trueBlack,
                                            fontWeight: FontWeight.w600),
                                      ),
                                      Divider(),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: bgWhite,
                                                border: Border(
                                                  right: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'RW',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    '${data.jumlahRw}',
                                                    style: TextStyle(
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
                                                border: Border(
                                                  right: BorderSide(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  ),
                                                ),
                                              ),
                                              child: Column(
                                                children: [
                                                  Text(
                                                    'RT',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    '${data.jumlahRt}',
                                                    style: TextStyle(
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
                                                  Text(
                                                    'KK',
                                                    style: TextStyle(
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                  Text(
                                                    '${data.jumlahKk}',
                                                    style: TextStyle(
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
                                          return DataRekapAKecamatanllShowmodal(
                                            function1: () {
                                              Get.to(() =>
                                                  DataRekapALlKelurahanPiechart(
                                                    title: data.namaKel,
                                                    idKec: data.idKel,
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
                  itemCount: dataTable.length,
                ),
        ));
  }
}

class DataRekapAKecamatanllShowmodal extends StatelessWidget {
  DataRekapAKecamatanllShowmodal(
      {super.key, required this.function1, this.isDeleteAdd = false});
  final void Function() function1;
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
            title: 'Lihat Detail Pie Chart Data',
            icon: Remix.pie_chart_2_line,
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
}
