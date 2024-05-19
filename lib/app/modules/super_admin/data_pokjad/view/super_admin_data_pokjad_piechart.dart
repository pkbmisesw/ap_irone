import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:http/http.dart' as http;
import 'package:irone/app/modules/data_pokjad/model/data_pokjad_model.dart';
import 'package:irone/app/modules/home/views/appbar.dart';
import 'package:irone/app/modules/home/widget/button_list.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MenuPokjadPieList extends StatefulWidget {
  const MenuPokjadPieList({super.key});

  @override
  State<MenuPokjadPieList> createState() => _MenuPokjadPieListState();
}

class _MenuPokjadPieListState extends State<MenuPokjadPieList> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  RxBool isLoading = true.obs;

  List<DataPokjadModel> chartData = [];
  void getData() async {
    try {
      List<DataPokjadModel> newData = await _fetchDataRekapPieChart();

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

  Future<List<DataPokjadModel>> _fetchDataRekapPieChart() async {
    final url = '${baseUrl}data-pokjad-view';
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final List<dynamic> responseData = json.decode(response.body)["data"];

        print(response.body);
        return responseData
            .map((item) => DataPokjadModel.fromJson(item))
            .toList();
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      print("Error fetching data: $e");
      throw e;
    }
  }

  double calculateTotal(List<DataPokjadModel> data,
      double Function(DataPokjadModel) getProperty) {
    return data.fold(
        0, (previousValue, element) => previousValue + getProperty(element));
  }

  List<String> listName = [
    'Jumlah Kader Posyandu',
    'Jumlah Kader Gizi',
    'Jumlah Kader Kesling',
    'Jumlah Kader Penyuluhan Narkoba',
    'Jumlah Kader PHBS',
    'Jumlah Kader KB',
    'Kesehatan Posyandu Jumlah',
    'Kesehatan Posyandu Terintegrasi',
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
      appBar: AppBarUniversal(title: 'Data Pokja 4 List Pie Chart'),
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
                                      (element) => element.jKPos.toDouble());
                                  double totalDatarw = calculateTotal(chartData,
                                      (element) => element.jKGizi.toDouble());

                                  if (index == 0) {
                                    Get.to(() => SuperDataPokjadPieScreen(
                                          title:
                                              'Perbandingan Total ${listName[0]} dan Total ${listName[1]}',
                                          totalData1: totalDatart,
                                          totalData2: totalDatarw,
                                          name: [listName[0], listName[1]],
                                        ));
                                  } else if (index == 1) {
                                    double totalJkrt = calculateTotal(chartData,
                                        (element) => element.jKKes.toDouble());
                                    double totalDkk = calculateTotal(chartData,
                                        (element) => element.jKNar.toDouble());
                                    Get.to(() => SuperDataPokjadPieScreen(
                                          title:
                                              'Perbandingan Total ${listName[2]} dan Total ${listName[3]}',
                                          totalData1: totalJkrt,
                                          totalData2: totalDkk,
                                          name: [listName[2], listName[3]],
                                        ));
                                  } else if (index == 2) {
                                    double totalJatotall = calculateTotal(
                                        chartData,
                                        (element) => element.jKPhbs.toDouble());
                                    double totalJatotalp = calculateTotal(
                                        chartData,
                                        (element) => element.jKKB.toDouble());
                                    Get.to(() => SuperDataPokjadPieScreen(
                                          title:
                                              'Perbandingan Total ${listName[4]} dan Total ${listName[5]}',
                                          totalData1: totalJatotall,
                                          totalData2: totalJatotalp,
                                          name: [listName[4], listName[5]],
                                        ));
                                  } else if (index == 3) {
                                    double totalJabalitaL = calculateTotal(
                                        chartData,
                                        (element) =>
                                            element.kpJumlah.toDouble());
                                    double totalJabalitaP = calculateTotal(
                                        chartData,
                                        (element) =>
                                            element.kpJumlahI.toDouble());
                                    Get.to(() => SuperDataPokjadPieScreen(
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

class SuperDataPokjadPieScreen extends StatefulWidget {
  final String title;
  final double totalData1;
  final double totalData2;
  final List<String> name;

  const SuperDataPokjadPieScreen(
      {super.key,
      required this.totalData1,
      required this.totalData2,
      required this.title,
      required this.name});

  @override
  _SuperDataPokjadPieScreenState createState() =>
      _SuperDataPokjadPieScreenState();
}

class _SuperDataPokjadPieScreenState extends State<SuperDataPokjadPieScreen> {
  RxBool isLoading = true.obs;

  List<double> dataValues = [1];
  List<DataPokjadModel> chartData = [];

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
            'Data Pokja 4 Pie Chart',
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
