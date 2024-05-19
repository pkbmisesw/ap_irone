import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irone/app/services/data_services/data_services.dart';
import 'package:fl_chart/fl_chart.dart';

import '../models/model_chart.dart';

class DataRekapBarScreen extends StatefulWidget {
  @override
  _DataRekapBarScreenState createState() => _DataRekapBarScreenState();
}

class _DataRekapBarScreenState extends State<DataRekapBarScreen> {
  final DataServices dataServices = DataServices();

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<ModelChartApi> chartData = [];

  List<int> dataApi = [];

  //fungsi ambil data
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

  LinearGradient get _barsGradient => LinearGradient(
        colors: [Colors.purple, Colors.cyan],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> barGroupData2 =
        List.generate(dataApi.length, (index) {
      return BarChartGroupData(
        // x adalah tempat bar ditampilkan di yang keberapa
        x: index,
        barRods: [
          //toy itu y atau value data
          BarChartRodData(
              gradient: _barsGradient, toY: dataApi[index].toDouble()),
        ],
      );
    });

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
          'Data Bar Chart',
          style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500, color: Color(0xffB00020)),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Bar Chart',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffB00020)),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Container(
                height: MediaQuery.of(context).size.height / 3,
                width: MediaQuery.of(context).size.width,
                child: BarChart(BarChartData(
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true),
                    ),
                    topTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  barTouchData: BarTouchData(allowTouchBarBackDraw: true),
                  barGroups: barGroupData2,
                )),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
