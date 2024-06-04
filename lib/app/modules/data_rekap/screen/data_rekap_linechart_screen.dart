import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:silahan_kawan/app/services/data_services/data_services.dart';
import 'package:fl_chart/fl_chart.dart';

import '../models/model_chart.dart';

class DataRekapLineScreen extends StatefulWidget {
  @override
  _DataRekapLineScreenState createState() => _DataRekapLineScreenState();
}

class _DataRekapLineScreenState extends State<DataRekapLineScreen> {
  final DataServices dataServices = DataServices();

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<ModelChartApi> chartData = [];

  List<int> dataApi = [];

  void getData() async {
    try {
      List<ModelChartApi> newData = await dataServices.fetchPieChart();

      setState(() {
        chartData = newData;
        dataApi = chartData.map((data) => data.jkk_tabung).toList();
      });
    } catch (e) {
      print("Error: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<FlSpot> dataSpot = List.generate(dataApi.length, (index) {
      return FlSpot(
        index.toDouble(),
        dataApi[index].toDouble(),
      );
    });

    //posisi
    List<FlSpot> dataTry = [
      FlSpot(1, 1),
      FlSpot(2, 4),
      FlSpot(3, 10),
      FlSpot(4, 10),
    ];

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
          'Data Line Chart',
          style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500, color: Color(0xffB00020)),
        ),
      ),
      body: Column(
        children: [
          Text('Line Chart Api'),
          Container(
            height: 200,
            width: double.infinity,
            child: LineChart(LineChartData(
                borderData: FlBorderData(
                  show: true,
                ),
                gridData: FlGridData(
                    show: true,
                    horizontalInterval:
                        10.0), // Menampilkan garis grid setiap 10 unit

                lineBarsData: [
                  LineChartBarData(
                    color: Color(0xffB00020),
                    spots: dataSpot, // Menyertakan data titik pada grafik
                  )
                ])),
          ),
          SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }
}
