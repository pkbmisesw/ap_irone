import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:irone/app/modules/data_umum/model/model_chart.dart';
import 'package:irone/app/services/data_services/data_services.dart';
import 'package:fl_chart/fl_chart.dart';

class AdminKecDataUmumBarScreen extends StatefulWidget {
  @override
  _AdminKecDataUmumBarScreenState createState() =>
      _AdminKecDataUmumBarScreenState();
}

class _AdminKecDataUmumBarScreenState extends State<AdminKecDataUmumBarScreen> {
  final DataServices dataServices = DataServices();

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<ModelChartApiUmum> chartData = [];

  List<int> dataApi = [];

  //fungsi ambil data
  void getData() async {
    try {
      List<ModelChartApiUmum> newData =
          await dataServices.fetchDataUmumPieChart(useIdKec: true);

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
          'Data Umum Bar Chart',
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
