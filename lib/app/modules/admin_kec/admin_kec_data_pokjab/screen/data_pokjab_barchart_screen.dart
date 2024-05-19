import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:irone/app/modules/data_pokjab/models/data_pokjab.dart';
import 'package:irone/app/modules/data_pokjab/models/data_pokjab_model.dart';
import 'package:irone/app/modules/data_rekap/widget/sizedbox_extension.dart';
import 'package:irone/app/services/data_services/data_pokjab_services.dart';
import 'package:irone/app/widgets/selector/multi_select.dart';
import 'package:irone/app/widgets/selector/single_select.dart';
import 'package:irone/theme.dart';

class AdminKecDataPokjabBarScreen extends StatefulWidget {
  @override
  _AdminKecDataPokjabBarScreenState createState() =>
      _AdminKecDataPokjabBarScreenState();
}

class _AdminKecDataPokjabBarScreenState
    extends State<AdminKecDataPokjabBarScreen> {
  final DataPokjabServices dataServices = DataPokjabServices();

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<DataPokjabModel> chartData = [];

  List<int> dataApi = [];

  //fungsi ambil data
  void getData() async {
    try {
      List<DataPokjabModel> newData = await dataServices
          .fetchDataPokjaChartnew('data_pokjab', useIdKec: true);

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
    return DataPokjab().datas.map(
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
        case 'JUMLAH WARGA YANG MASIH 3 BUTA	Laki':
          return data.jWmL;
        case 'JUMLAH WARGA YANG MASIH 3 BUTA	Perempuan':
          return data.jWmP;
        case 'Jumlah Paket A Kel. Belajar':
          return data.jABel;
        case 'Jumlah Paket A Warga Belajar':
          return data.jAWBel;
        case 'Jumlah Paket B Kel. Belajar':
          return data.jBBel;
        case 'Jumlah Paket B Warga Belajar':
          return data.jBWBel;
        case 'Jumlah Paket C Kel. Belajar':
          return data.jCBel;
        case 'Jumlah Paket C Warga Belajar':
          return data.jCWBel;
        case 'Jumlah KF Belajar':
          return data.jKfBel;
        case 'Jumlah Kj Warga Belajar':
          return data.jKfWBel;
        case 'Jumlah Paud Sejenis':
          return data.jPaudSJenis;
        case 'Jumlah Taman Baca Perpus':
          return data.jTbmPer;
        case 'Jumlah BKB Kelompok':
          return data.jBkbKel;
        case 'Jumlah BKB Ibu Peserta':
          return data.jBkbIbu;
        case 'Jumlah BKB Ape(SET)':
          return data.jBkbApe;
        case 'Jumlah BKB Kel Simulasi':
          return data.jBkbSim;
        case 'Jumlah Kader Tutor KF':
          return data.jKtKf;
        case 'Jumlah Kader Tutor Paud':
          return data.jKtPaud;
        case 'Jumlah kader BKB':
          return data.jKBkb;
        case 'Jumlah Kader Koperasi':
          return data.jKKop;
        case 'Jumlah Kader Keterampilan':
          return data.jKKet;
        case 'Jumlah Kader Latih LP3PKK':
          return data.jKLlpt;
        case 'Jumlah Kader Latih TP3PKK':
          return data.jKLtpk;
        case 'Jumlah Kader Latih Damas PKK':
          return data.jKLdamas;
        case 'Pengembangan Koperasi Pemula Kelompok':
          return data.pKopPemKel;
        case 'Pengembangan Koperasi Pemula Peserta':
          return data.pKopPemPes;
        case 'Pengembangan Koperasi Madya Kelompok':
          return data.pKopMadKel;
        case 'Pengembangan Koperasi Madya Peserta':
          return data.pKopMadPes;
        case 'Pengembangan Koperasi Utama Kelompok':
          return data.pKopUtKel;
        case 'Pengembangan Koperasi Utama Peserta':
          return data.pKopMutPes;
        case 'Pengembangan Koperasi Mandiri Kelompok':
          return data.pKopManKel;
        case 'Pengembangan Koperasi Mandiri Peserta':
          return data.pKopManPes;
        case 'Koperasi Badan Hukum Jumlah Kelompok':
          return data.jKBkb;
        case 'Koperasi Badan Hukum Jumlah Peserta':
          return data.jKKop;
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
          'Data Pokja 2 Bar Chart',
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
