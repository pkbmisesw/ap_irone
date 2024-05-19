import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:irone/app/modules/data_pokjac/model/data_pokjac.dart';
import 'package:irone/app/modules/data_pokjac/model/data_pokjac_model.dart';
import 'package:irone/app/services/data_services/data_pokjac_services.dart';
import 'package:irone/app/widgets/selector/multi_select.dart';
import 'package:irone/app/widgets/selector/single_select.dart';
import 'package:irone/theme.dart';

class AdminKecDataPokjacLineScreen extends StatefulWidget {
  @override
  _AdminKecDataPokjacLineScreenState createState() =>
      _AdminKecDataPokjacLineScreenState();
}

class _AdminKecDataPokjacLineScreenState
    extends State<AdminKecDataPokjacLineScreen> {
  final DataPokjacServices dataServices = DataPokjacServices();

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<DataPokjacModel> chartData = [];

  List<int> dataApi = [];

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

  List<SelectItem<String>> get dataOption {
    return DataPokjac().datas.map(
      (location) {
        return SelectItem(label: location, value: location);
      },
    ).toList();
  }

  @override
  Widget build(BuildContext context) {
    List<FlSpot> dataSpot = List.generate(dataApi.length, (index) {
      return FlSpot(
        index.toDouble(),
        dataApi[index].toDouble(),
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
          'Data Pokja 3 Line Chart',
          style: GoogleFonts.outfit(
              fontWeight: FontWeight.w500, color: Color(0xffB00020)),
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
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
          SizedBox(
            height: 20,
          ),
          Container(
            height: 250,
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
