import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:irone/app/modules/data_pokjad/model/data_pokjad.dart';
import 'package:irone/app/modules/data_pokjad/model/data_pokjad_model.dart';
import 'package:irone/app/modules/data_rekap/widget/sizedbox_extension.dart';
import 'package:irone/app/services/data_services/data_pokjad_services.dart';
import 'package:irone/app/widgets/selector/multi_select.dart';
import 'package:irone/app/widgets/selector/single_select.dart';
import 'package:irone/theme.dart';

class AdminKecDataPokjadBarScreen extends StatefulWidget {
  @override
  _AdminKecDataPokjadBarScreenState createState() =>
      _AdminKecDataPokjadBarScreenState();
}

class _AdminKecDataPokjadBarScreenState
    extends State<AdminKecDataPokjadBarScreen> {
  final DataPokjadServices dataServices = DataPokjadServices();

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<DataPokjadModel> chartData = [];

  List<int> dataApi = [1, 3, 4];

  //fungsi ambil data
  void getData() async {
    try {
      List<DataPokjadModel> newData = await dataServices
          .fetchDataPokjaChartnew('data_pokjad', useIdKec: true);

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
    return DataPokjad().datas.map(
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
        case 'Jumlah Kader Posyandu':
          return data.jKPos;
        case 'Jumlah Kader Gizi':
          return data.jKGizi;
        case 'Jumlah Kader Kesling':
          return data.jKKes;
        case 'Jumlah Kader Penyuluhan Narkoba':
          return data.jKNar;
        case 'Jumlah Kader PHBS':
          return data.jKPhbs;
        case 'Jumlah Kader KB':
          return data.jKKB;
        case 'Kesehatan Posyandu Jumlah':
          return data.kpJumlah;
        case 'Kesehatan Posyandu Terintegrasi':
          return data.kpJumlahI;
        case 'Kesehatan Posyandu Lansia Jumlah Kelompok':
          return data.kpLanJK;
        case 'Kesehatan Posyandu Lansia Jumlah Anggota':
          return data.kpLanJA;
        case 'Kesehatan Posyandu Lansia Jumlah Memiliki Kartu':
          return data.kpLanBG;
        case 'Jumlah Jamban':
          return data.jJamban;
        case 'Jumlah SPAL':
          return data.jSPAL;
        case 'Jumlah Tempat Pembuangan Sampah':
          return data.jSampah;
        case 'Jumlah MCK':
          return data.jMCK;
        case 'Jumlah KRT PDAM':
          return data.jKPdam;
        case 'Jumlah KRT SUMUR':
          return data.jKSumur;
        case 'Jumlah KRT SUNGAI':
          return data.jKSungai;
        case 'Jumlah KRT Lain-Lain':
          return data.jKLain;
        case 'Jumlah PUS':
          return data.jPus;
        case 'Jumlah WUS':
          return data.jWus;
        case 'JUMLAH AKSEPTOR KB Laki':
          return data.jaL;
        case 'JUMLAH AKSEPTOR KB Perempuan':
          return data.jaP;
        case 'JUMLAH KK YANG MEMILIKI TABUNGAN':
          return data.jKK;

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
          'Data Pokja 4 Bar Chart',
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
                      axisNameWidget: Text('ok'),
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                      ),
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
