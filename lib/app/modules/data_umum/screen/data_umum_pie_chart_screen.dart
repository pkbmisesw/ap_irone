import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:silahan_kawan/app/modules/data_umum/model/data_umum_models.dart';
import 'package:silahan_kawan/app/modules/home/views/appbar.dart';
import 'package:silahan_kawan/app/modules/home/widget/button_list.dart';
import 'package:silahan_kawan/app/services/data_services/data_services.dart';

class DataUmumPieScreen extends StatefulWidget {
  const DataUmumPieScreen({super.key});

  @override
  State<DataUmumPieScreen> createState() => _DataUmumPieScreenState();
}

class _DataUmumPieScreenState extends State<DataUmumPieScreen> {
  final DataServices dataServices = DataServices();
  @override
  void initState() {
    super.initState();
    getData();
  }

  RxBool isLoading = true.obs;

  List<DataUmumModel> chartData = [];
  void getData() async {
    try {
      List<DataUmumModel> newData =
          await dataServices.fetchDataUmumPiePerbandinganChart();

      setState(() {
        chartData = newData;
      });

      print(newData);
      isLoading.value = false;
    } catch (e) {
      print("Error: $e");
    }
  }

  String? baseUrl = dotenv.env['BASE_URL'];

  Future<List<DataUmumModel>> _fetchDataRekapPieChart() async {
    final url = '${baseUrl}data-umum-view';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)["data"];

        print(response.body);
        return responseData
            .map((item) => DataUmumModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
    }
  }

  double calculateTotal(
      List<DataUmumModel> data, double Function(DataUmumModel) getProperty) {
    return data.fold(
        0, (previousValue, element) => previousValue + getProperty(element));
  }

  List<String> listName = [
    "Anggota TP PKK Laki",
    "Anggota TP PKK Perempuan",
    "TENAGA SEKRETARIAT Honorer Laki",
    "TENAGA SEKRETARIAT Honorer Perempuan",
    "Kader Khusus Laki",
    "Kader Khusus Perempuan",
    "TENAGA SEKRETARIAT Bantuan Laki",
    "TENAGA SEKRETARIAT Bantuan Perempuan",
  ];

  @override
  Widget build(BuildContext context) {
    final dataName = [
      'Perbandingan Total ${listName[0]} dan Total ${listName[1]}',
      'Perbandingan Total ${listName[2]} dan Total ${listName[3]}',
      'Perbandingan Total ${listName[4]} dan Total ${listName[5]}',
      'Perbandingan Total ${listName[6]} dan Total ${listName[7]}',
    ];

    return Scaffold(
      appBar: AppBarUniversal(title: 'Data Umum List Pie Chart'),
      body: Padding(
          padding: const EdgeInsets.all(24),
          child: Obx(
            () => isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: List.generate(4, (index) {
                      return Container(
                        margin: EdgeInsets.only(bottom: 12),
                        child: InkWell(
                          child: UnExpandableRecords(
                            data: SettingData(
                                image: 'assets/img/pie.png',
                                title: dataName[index],
                                onTap: () {
                                  double totalDatart = calculateTotal(chartData,
                                      (element) => element.aLaki.toDouble());
                                  double totalDatarw = calculateTotal(chartData,
                                      (element) => element.aLaki.toDouble());

                                  if (index == 0) {
                                    Get.to(() => SuperDataUmumPieScreen(
                                          title:
                                              'Perbandingan Total ${listName[0]} dan Total ${listName[1]}',
                                          totalData1: totalDatart,
                                          totalData2: totalDatarw,
                                          name: [listName[0], listName[1]],
                                        ));
                                  } else if (index == 1) {
                                    double totalJkrt = calculateTotal(chartData,
                                        (element) => element.hLaki.toDouble());
                                    double totalDkk = calculateTotal(
                                        chartData,
                                        (element) =>
                                            element.hPerempuan.toDouble());
                                    Get.to(() => SuperDataUmumPieScreen(
                                          title:
                                              'Perbandingan Total ${listName[2]} dan Total ${listName[3]}',
                                          totalData1: totalJkrt,
                                          totalData2: totalDkk,
                                          name: [listName[2], listName[3]],
                                        ));
                                  } else if (index == 2) {
                                    double totalJatotall = calculateTotal(
                                        chartData,
                                        (element) => element.kLaki.toDouble());
                                    double totalJatotalp = calculateTotal(
                                        chartData,
                                        (element) =>
                                            element.kPerempuan.toDouble());
                                    Get.to(() => SuperDataUmumPieScreen(
                                          title:
                                              'Perbandingan Total ${listName[4]} dan Total ${listName[5]}',
                                          totalData1: totalJatotall,
                                          totalData2: totalJatotalp,
                                          name: [listName[4], listName[5]],
                                        ));
                                  } else if (index == 3) {
                                    double totalJabalitaL = calculateTotal(
                                        chartData,
                                        (element) => element.bLaki.toDouble());
                                    double totalJabalitaP = calculateTotal(
                                        chartData,
                                        (element) =>
                                            element.bPerempuan.toDouble());
                                    Get.to(() => SuperDataUmumPieScreen(
                                          title:
                                              'Perbandingan Total ${listName[6]} dan Total ${listName[7]}',
                                          totalData1: totalJabalitaL,
                                          totalData2: totalJabalitaP,
                                          name: [listName[6], listName[7]],
                                        ));
                                  } else {}
                                },
                                children: []),
                          ),
                        ),
                      );
                    }),
                  ),
          )),
    );
  }
}

class SuperDataUmumPieScreen extends StatefulWidget {
  final String title;
  final double totalData1;
  final double totalData2;
  final List<String> name;

  const SuperDataUmumPieScreen(
      {super.key,
      required this.totalData1,
      required this.totalData2,
      required this.title,
      required this.name});

  @override
  _SuperDataUmumPieScreenState createState() => _SuperDataUmumPieScreenState();
}

class _SuperDataUmumPieScreenState extends State<SuperDataUmumPieScreen> {
  RxBool isLoading = true.obs;

  List<double> dataValues = [1];
  List<DataUmumModel> chartData = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    try {
      print('${widget.totalData1},${widget.totalData2}');
      setState(() {
        dataValues = [
          widget.totalData1, widget.totalData2,
          // totalRw, totalRt
        ];
      });

      print(dataValues);
      isLoading.value = false;
    } catch (e) {
      print("Error: $e");
    }
  }

  final List<Color> colorList = [
    Colors.green,
    Colors.yellow,
    Colors.orange,
    Colors.purple,
    Colors.pink,
    Colors.teal,
    Colors.cyan,
    Colors.amber,
  ];

  @override
  Widget build(BuildContext context) {
    double total = dataValues.reduce((value, element) => value + element);

    return Scaffold(
        appBar: AppBar(
          shadowColor: Colors.black,
          backgroundColor: Colors.white,
          elevation: 2,
          leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xffB00020),
            ),
          ),
          title: Text(
            'Data Umum Pie Chart',
            style: GoogleFonts.outfit(
                fontWeight: FontWeight.w500, color: Color(0xffB00020)),
          ),
        ),
        body: Obx(
          () => isLoading.value
              ? Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Diagram Pie Chart ${widget.title}',
                          style: TextStyle(
                              color: Color(0xffB00020),
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 400,
                      width: double.infinity,
                      child: PieChart(
                        PieChartData(
                          sectionsSpace: 2,
                          centerSpaceRadius: 40,
                          sections: List.generate(
                            dataValues.length,
                            (i) {
                              int dataIndex = i % colorList.length;
                              Color colors = colorList[dataIndex];
                              final double percentage =
                                  (dataValues[i] / total) * 100;
                              final name = widget.name[i];
                              return PieChartSectionData(
                                borderSide: BorderSide(color: Colors.black),
                                color: colors,
                                value: percentage,
                                title:
                                    '${percentage.toStringAsFixed(1)}% \n $name',
                                radius: 100,
                                titleStyle: TextStyle(
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
        ));
  }
}
