import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:irone/app/modules/data_pokjac/model/data_pokjac.dart';
import 'package:irone/app/modules/data_pokjac/model/data_pokjac_model.dart';
import 'package:irone/app/modules/data_rekap/widget/sizedbox_extension.dart';
import 'package:irone/app/services/data_services/data_pokjac_services.dart';
import 'package:irone/app/widgets/selector/multi_select.dart';
import 'package:irone/app/widgets/selector/single_select.dart';
import 'package:irone/theme.dart';

class AdminKecDataPokjacBarScreen extends StatefulWidget {
  @override
  _AdminKecDataPokjacBarScreenState createState() =>
      _AdminKecDataPokjacBarScreenState();
}

class _AdminKecDataPokjacBarScreenState
    extends State<AdminKecDataPokjacBarScreen> {
  final DataPokjacServices dataServices = DataPokjacServices();

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<DataPokjacModel> chartData = [];

  List<int> dataApi = [];

  //fungsi ambil data
  void getData() async {
    try {
      List<DataPokjacModel> newData = await dataServices
          .fetchDataPokjaChartnew('data_pokjac', useIdKec: true);

      setState(() {
        chartData = newData;
        dataApi = chartData.map((data) => data.status).toList();
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

  List<SelectItem<String>> get dataOption {
    return DataPokjac().datas.map(
      (location) {
        return SelectItem(label: location, value: location);
      },
    ).toList();
  }

  String selectedValue = 'Status';
  void updateDataApi(String property) {
    if (chartData.isEmpty) return;

    dataApi = chartData.map<int>((data) {
      switch (property) {
        case 'ID':
          return data.id;
        case 'ID Kecamatan':
          return data.idKec;
        case 'ID Kelurahan':
          return data.idKel;
        case 'Jumlah Kader Pangan':
          return data.jKPangan;
        case 'Jumlah Kader Sandang':
          return data.jKSandang;
        case 'Jumlah Kader Tata Laksana Rumah Tangga':
          return data.jKTaRt;
        case 'Pangan Makanan Pokok Beras':
          return data.pMpBeras;
        case 'Pangan Makanan Pokok Non Beras':
          return data.pMpNberas;
        case 'Pangan Pemanfaatan Pekarangan Peternakan':
          return data.pPPTernak;
        case 'Pangan Pemanfaatan Pekarangan Perikanan':
          return data.pPPIkan;
        case 'Pangan Pemanfaatan Pekarangan Warung Hidup':
          return data.pPPWarung;
        case 'Pangan Pemanfaatan Pekarangan Lumbung Hidup':
          return data.pPPLumbung;
        case 'Pangan Pemanfaatan Pekarangan Toga':
          return data.pPPToga;
        case 'Pangan Pemanfaatan Pekarangan Tanaman Keras':
          return data.pPPTkeras;
        case 'Jumlah Industri Pangan':
          return data.jiPangan;
        case 'Jumlah Industri Sandang':
          return data.jiSandang;
        case 'Jumlah Industri Jasa':
          return data.jiJasa;
        case 'Jumlah Rumah Sehat':
          return data.jrSehat;
        case 'Jumlah Rumah Tidak Sehat':
          return data.jrTsehat;
        case 'Status':
          return data.status;
        default:
          return 0;
      }
    }).toList();

    setState(() {});
  }

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
          'Data Pokja 3 Bar Chart',
          style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500, color: Color(0xffB00020)),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            20.heightBox,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      'Value : $selectedValue',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                          color: trueBlack, fontWeight: FontWeight.w500),
                    ),
                  ),
                  ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: bgRed),
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) => SingleSelect(
                            items: dataOption,
                            onSelect: (selectedValueItem) {
                              selectedValue = selectedValueItem ?? '';
                              updateDataApi(selectedValue);
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Pick Value',
                        style: GoogleFonts.poppins(color: bgWhite),
                      )),
                ],
              ),
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
                height: MediaQuery.of(context).size.height * 0.4,
                width: MediaQuery.of(context).size.width,
                child: BarChart(BarChartData(
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles:
                          SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles:
                          SideTitles(showTitles: true, reservedSize: 40),
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
