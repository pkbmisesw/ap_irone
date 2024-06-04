import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:silahan_kawan/app/modules/data_rekap/models/model_chart.dart';
import 'package:silahan_kawan/app/modules/data_rekap/widget/sizedbox_extension.dart';
import 'package:silahan_kawan/app/modules/home/views/appbar.dart';
import 'package:silahan_kawan/app/services/data_services/data_services.dart';
import 'package:silahan_kawan/theme.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import '../model/data_rekap_all_kecmaatan_pie_model.dart';

class DataRekapAllBarKecamatan extends StatefulWidget {
  const DataRekapAllBarKecamatan(
      {Key? key, required this.title, required this.idKec})
      : super(key: key);
  final String title;
  final int idKec;

  @override
  State<DataRekapAllBarKecamatan> createState() =>
      _DataRekapAllPieKecamatanState();
}

class _DataRekapAllPieKecamatanState extends State<DataRekapAllBarKecamatan> {
  Rx<TotalDataModel?> totalData = Rx<TotalDataModel?>(null);
  final RxBool isLoading = true.obs;

  List<int> dataTotalWarga = [];
  List<int> dataTotalBalita = [];
  List<int> dataTotalWargaButa = [];
  List<int> dataTotalRumahWargaSehat = [];
  List<int> dataTotalRumahWargaTidakSehat = [];
  List<int> dataTotalKondisiRumah = [];
  List<int> dataTotalIndustri = [];

  List<int> dataTotalSumberAir = [];

  List<int> dataTotalMakananPokok = [];
  List<int> dataTotalPemanfaatanTanah = [];
  List<int> dataTotalIbuHamil = [];

  Future<void> fetchTotalDataFromApi() async {
    try {
      isLoading.value = true;
      final response = await http.get(Uri.parse(
          'https://app2.tppkk-bitung.com/api/data-rekap-kecamatan/${widget.idKec}'));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)["data"]['data_total'];
        totalData.value = TotalDataModel.fromJson(responseData);

        dataTotalWarga = [
          int.tryParse(totalData.value!.totalWarga.totalWargaLaki) ?? 0,
          int.tryParse(totalData.value!.totalWarga.totalWargaPerempuan) ?? 0,
        ];

        dataTotalBalita = [
          int.tryParse(totalData.value!.totalBalita.totalBalitaLaki) ?? 0,
          int.tryParse(totalData.value!.totalBalita.totalBalitaPerempuan) ?? 0,
        ];

        dataTotalWargaButa = [
          int.tryParse(totalData.value!.totalWargaButa.totalButaLaki) ?? 0,
          int.tryParse(totalData.value!.totalWargaButa.totalButaPerempuan) ?? 0,
        ];

        dataTotalRumahWargaSehat = [
          int.tryParse(totalData.value!.totalRumahWarga.totalRumahSehat) ?? 0,
          int.tryParse(totalData.value!.totalRumahWarga.totalRumahTidakSehat) ??
              0,
        ];

        dataTotalKondisiRumah = [
          int.tryParse(totalData.value!.totalKondisiRumah.totalTempatSampah) ??
              0,
          int.tryParse(totalData.value!.totalKondisiRumah.totalSpal) ?? 0,
          int.tryParse(
                  totalData.value!.totalKondisiRumah.totalJambanKeluarga) ??
              0,
          int.tryParse(totalData.value!.totalKondisiRumah.totalStikerP4k) ?? 0,
        ];

        dataTotalSumberAir = [
          int.tryParse(totalData.value!.totalSumberAir.totalPdam) ?? 0,
          int.tryParse(totalData.value!.totalSumberAir.totalSumur) ?? 0,
          int.tryParse(totalData.value!.totalSumberAir.totalSungai) ?? 0,
          int.tryParse(totalData.value!.totalSumberAir.totalDll) ?? 0,
        ];

        dataTotalMakananPokok = [
          int.tryParse(totalData.value!.totalMakananPokok.totalBeras) ?? 0,
          int.tryParse(totalData.value!.totalMakananPokok.totalNonBeras) ?? 0,
        ];

        dataTotalPemanfaatanTanah = [
          int.tryParse(totalData.value!.totalPemanfaatanTanah.totalTernak) ?? 0,
          int.tryParse(totalData.value!.totalPemanfaatanTanah.totalIkan) ?? 0,
          int.tryParse(
                  totalData.value!.totalPemanfaatanTanah.totalWarungHidup) ??
              0,
          int.tryParse(
                  totalData.value!.totalPemanfaatanTanah.totalLumbungHidup) ??
              0,
          int.tryParse(totalData.value!.totalPemanfaatanTanah.totalToga) ?? 0,
          int.tryParse(
                  totalData.value!.totalPemanfaatanTanah.totalTanamanKeras) ??
              0,
        ];

        dataTotalIbuHamil = [
          int.tryParse(totalData.value!.totalIbuDanBalita.toalibuhamil) ?? 0,
          int.tryParse(totalData.value!.totalIbuDanBalita.totalibumenyusui) ??
              0,
          int.tryParse(totalData.value!.totalIbuDanBalita.totalbalita) ?? 0,
        ];

        dataTotalIndustri = [
          int.tryParse(totalData.value!.totalIndustri.totaljasa) ?? 0,
          int.tryParse(totalData.value!.totalIndustri.totalsandang) ?? 0,
          int.tryParse(totalData.value!.totalIndustri.totaljasa) ?? 0,
        ];

        setState(() {});
      } else {
        throw Exception('Failed to fetch data');
      }
    } catch (e) {
      print(e);
    }

    isLoading.value = false;
  }

  RxInt totalWarga = 0.obs;
  RxInt totalBalita = 0.obs;
  RxInt totalWargaButa = 0.obs;
  RxInt totalRumahWargaSehat = 0.obs;
  RxInt totalRumahWargaTidakSehat = 0.obs;
  RxInt totalKondisiRumah = 0.obs;
  RxInt totalIndustri = 0.obs;

  final DataServices dataServices = DataServices();

  @override
  void initState() {
    super.initState();
    fetchTotalDataFromApi();
  }

  LinearGradient get _barsGradient => LinearGradient(
        colors: [Colors.purple, Colors.cyan],
        begin: Alignment.bottomCenter,
        end: Alignment.topCenter,
      );

  @override
  Widget build(BuildContext context) {
    List<BarChartGroupData> barchartGroupTotalWarga =
        List.generate(dataTotalWarga.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            gradient: _barsGradient,
            toY: dataTotalWarga[index].toDouble(),
          ),
        ],
      );
    });

    List<BarChartGroupData> barchartGroupTotalBalita =
        List.generate(dataTotalBalita.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            gradient: _barsGradient,
            toY: dataTotalBalita[index].toDouble(),
          ),
        ],
      );
    });

    List<BarChartGroupData> barchartGroupTotalWargaButa =
        List.generate(dataTotalWargaButa.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            gradient: _barsGradient,
            toY: dataTotalWargaButa[index].toDouble(),
          ),
        ],
      );
    });

    List<BarChartGroupData> barchartGroupTotalRumahWargaSehat =
        List.generate(dataTotalRumahWargaSehat.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            gradient: _barsGradient,
            toY: dataTotalRumahWargaSehat[index].toDouble(),
          ),
        ],
      );
    });

    List<BarChartGroupData> barchartGroupTotalRumahWargaTidakSehat =
        List.generate(dataTotalRumahWargaTidakSehat.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            gradient: _barsGradient,
            toY: dataTotalRumahWargaTidakSehat[index].toDouble(),
          ),
        ],
      );
    });

    List<BarChartGroupData> barchartGroupTotalKondisiRumah =
        List.generate(dataTotalKondisiRumah.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            gradient: _barsGradient,
            toY: dataTotalKondisiRumah[index].toDouble(),
          ),
        ],
      );
    });

    List<BarChartGroupData> barchartGroupdataTotalMakananPokok =
        List.generate(dataTotalMakananPokok.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            gradient: _barsGradient,
            toY: dataTotalMakananPokok[index].toDouble(),
          ),
        ],
      );
    });

    List<BarChartGroupData> barchartGroupTotalTotalPemanfaatanTanah =
        List.generate(dataTotalPemanfaatanTanah.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            gradient: _barsGradient,
            toY: dataTotalPemanfaatanTanah[index].toDouble(),
          ),
        ],
      );
    });

    List<BarChartGroupData> barchartGroupdataTotalIbuHamil =
        List.generate(dataTotalIbuHamil.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            gradient: _barsGradient,
            toY: dataTotalIbuHamil[index].toDouble(),
          ),
        ],
      );
    });

    List<BarChartGroupData> barchartGroupTotalIndustri =
        List.generate(dataTotalIndustri.length, (index) {
      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            gradient: _barsGradient,
            toY: dataTotalIndustri[index].toDouble(),
          ),
        ],
      );
    });

    return Scaffold(
      appBar: AppBarUniversal(title: 'Data Barchart ${widget.title}'),
      body: Obx(() => isLoading.value
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              children: [
                ReusableBarChart(
                    title: 'Total Warga',
                    barGroupData: barchartGroupTotalWarga),
                ReusableBarChart(
                    title: 'Total Balita',
                    barGroupData: barchartGroupTotalBalita),
                ReusableBarChart(
                    title: 'Total Warga Buta',
                    barGroupData: barchartGroupTotalWargaButa),
                ReusableBarChart(
                    title: 'Total Rumah Warga Sehat',
                    barGroupData: barchartGroupTotalRumahWargaSehat),
                ReusableBarChart(
                    title: 'Total Rumah Warga Tidak Sehat',
                    barGroupData: barchartGroupTotalRumahWargaTidakSehat),
                ReusableBarChart(
                    title: 'Total Kondisi Rumah',
                    barGroupData: barchartGroupTotalKondisiRumah),
                ReusableBarChart(
                    title: 'Total Makanan Pokok',
                    barGroupData: barchartGroupdataTotalMakananPokok),
                ReusableBarChart(
                    title: 'Total Pemanfaatan Tanah',
                    barGroupData: barchartGroupTotalTotalPemanfaatanTanah),
                ReusableBarChart(
                    title: 'Total ibu dan Baltia',
                    barGroupData: barchartGroupdataTotalIbuHamil),
                ReusableBarChart(
                    title: 'Total Industri',
                    barGroupData: barchartGroupTotalIndustri),
              ],
            )),
    );
  }
}

class ReusableBarChart extends StatelessWidget {
  final String title;
  final List<BarChartGroupData> barGroupData;

  const ReusableBarChart({
    Key? key,
    required this.title,
    required this.barGroupData,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Container(
            height: MediaQuery.of(context).size.height / 3,
            width: MediaQuery.of(context).size.width,
            child: BarChart(
              BarChartData(
                titlesData: FlTitlesData(
                  show: true,
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
                barGroups: barGroupData,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
