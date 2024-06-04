import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:silahan_kawan/app/widgets/selector/multi_select.dart';
import 'package:silahan_kawan/app/widgets/selector/single_select.dart';
import 'package:silahan_kawan/theme.dart';

import '../../../services/data_services/data_pokjaa_services.dart';
import '../models/data_pokja.dart';
import '../models/data_pokja_model.dart';

class DataPokjaaLineScreen extends StatefulWidget {
  @override
  _DataPokjaaLineScreenState createState() => _DataPokjaaLineScreenState();
}

class _DataPokjaaLineScreenState extends State<DataPokjaaLineScreen> {
  final DataPokjaaServices dataServices = DataPokjaaServices();

  @override
  void initState() {
    super.initState();
    getData();
  }

  List<DataPokjaModel> chartData = [];

  List<int> dataApi = [];

  void getData() async {
    try {
      List<DataPokjaModel> newData =
          await dataServices.fetchDataPokjaChartnew('data_pokjaa');

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

  List<SelectItem<String>> get dataOption {
    return DataPokja().datas.map(
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
          'Data Pokja 1 Line Chart',
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
