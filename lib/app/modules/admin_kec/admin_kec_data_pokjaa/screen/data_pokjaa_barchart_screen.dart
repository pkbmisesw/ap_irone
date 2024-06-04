import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:silahan_kawan/app/modules/data_pokjaa/models/data_pokja.dart';
import 'package:silahan_kawan/app/modules/data_rekap/widget/sizedbox_extension.dart';
import 'package:silahan_kawan/app/services/data_services/data_pokjaa_services.dart';
import 'package:silahan_kawan/app/widgets/selector/multi_select.dart';
import 'package:silahan_kawan/app/widgets/selector/single_select.dart';
import 'package:silahan_kawan/theme.dart';

import '../../../data_pokjaa/models/data_pokja_model.dart';

class AdminKecDataPokjaaBarScreen extends StatefulWidget {
  @override
  _AdminKecDataPokjaaBarScreenState createState() =>
      _AdminKecDataPokjaaBarScreenState();
}

class _AdminKecDataPokjaaBarScreenState
    extends State<AdminKecDataPokjaaBarScreen> {
  final DataPokjaaServices dataServices = DataPokjaaServices();

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<DataPokjaModel> chartData = [];

  List<int> dataApi = [];

  //fungsi ambil data
  void getData() async {
    try {
      List<DataPokjaModel> newData = await dataServices
          .fetchDataPokjaChartnew('data_pokjaa', useIdKec: true);

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
    return DataPokja().datas.map(
      (location) {
        return SelectItem(label: location, value: location);
      },
    ).toList();
  }

  String selectedValue = 'Status';

  void updateDataApi(String property) {
    if (chartData.isEmpty) return;

    dataApi = chartData.map((data) {
      switch (property) {
        case 'ID':
          return data.id;
        case 'ID Kecamatan':
          return data.idKec;
        case 'ID Kelurahan':
          return data.idKel;
        case 'Jumlah PKBN':
          return data.jPkbn;
        case 'Jumlah PKDRT':
          return data.jPkdrt;
        case 'Pola Asuh':
          return data.pola;
        case 'P PKBN Simulasi':
          return data.pPkbnSim;
        case 'P PKBN Anggota':
          return data.pPkbnAnggota;
        case 'P PKDRT Simulasi':
          return data.pPkdrtSim;
        case 'P PKDRT Anggota':
          return data.pPkdrtAnggota;
        case 'Pola Kelompok':
          return data.polaKel;
        case 'Pola Anggota':
          return data.polaAnggota;
        case 'Lansia Kelompok':
          return data.lansiaKel;
        case 'Lansia Anggota':
          return data.lansiaAnggota;
        case 'Gotong Royong Jumlah Kerja Bakti':
          return data.gJumKer;
        case 'Gotong Royong Jumlah Rukung Kematian':
          return data.gJumRuk;
        case 'Gotong Royong Jumlah Keagamaan':
          return data.gJumAgama;
        case 'Gotong Royong Jumlah Jimpitan':
          return data.gJumJimpit;
        case 'Gotong Royong Jumlah Arisan':
          return data.gJumArisan;
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
          'Data Pokja 1 Bar Chart',
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
