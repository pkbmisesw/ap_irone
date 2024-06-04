import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:silahan_kawan/app/modules/home/views/appbar.dart';

import '../model/data_rekap_all_kecmaatan_pie_model.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'data_rekap_all_piechart_kecamatan.dart';

class DataRekapALlKelurahanPiechart extends StatefulWidget {
  const DataRekapALlKelurahanPiechart(
      {super.key, required this.title, required this.idKec});
  final String title;
  final int idKec;

  @override
  State<DataRekapALlKelurahanPiechart> createState() =>
      _DataRekapALlKelurahanPiechartState();
}

class _DataRekapALlKelurahanPiechartState
    extends State<DataRekapALlKelurahanPiechart> {
  Rx<TotalDataModel?> totalData = Rx<TotalDataModel?>(null);
  final RxBool isLoading = true.obs;

  Future<void> fetchTotalDataFromApi() async {
    try {
      final response = await http.get(Uri.parse(
          'https://app2.tppkk-bitung.com/api/data-rekap-kelurahan/${widget.idKec}'));
      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)["data"]['data_total'];
        totalData.value = TotalDataModel.fromJson(responseData);

        totalWarga.value =
            int.parse(totalData.value!.totalWarga.totalWargaLaki) +
                int.parse(totalData.value!.totalWarga.totalWargaPerempuan);

        totalBalita.value =
            int.parse(totalData.value!.totalBalita.totalBalitaLaki) +
                int.parse(totalData.value!.totalBalita.totalBalitaPerempuan);

        totalWargaButa.value =
            int.parse(totalData.value!.totalWargaButa.totalButaLaki) +
                int.parse(totalData.value!.totalWargaButa.totalButaPerempuan);

        totalRumahWargaSehat.value =
            int.parse(totalData.value!.totalRumahWarga.totalRumahSehat);
        totalRumahWargaTidakSehat.value =
            int.parse(totalData.value!.totalRumahWarga.totalRumahTidakSehat);

        // Menambahkan nilai total_kondisi_rumah
        totalKondisiRumah.value = int.parse(
                totalData.value!.totalKondisiRumah.totalTempatSampah) +
            int.parse(totalData.value!.totalKondisiRumah.totalSpal) +
            int.parse(totalData.value!.totalKondisiRumah.totalJambanKeluarga) +
            int.parse(totalData.value!.totalKondisiRumah.totalStikerP4k);

        print(totalData.value!.totalWarga.totalWargaLaki ?? '');
      } else {
        throw Exception('Failed to fetch data');
      }
      isLoading.value = false;
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    fetchTotalDataFromApi();
    super.initState();
  }

  RxInt totalWarga = 0.obs;
  RxInt totalBalita = 0.obs;
  RxInt totalWargaButa = 0.obs;
  RxInt totalRumahWargaSehat = 0.obs;
  RxInt totalRumahWargaTidakSehat = 0.obs;
  RxInt totalKondisiRumah = 0.obs; // RxInt baru untuk total_kondisi_rumah

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarUniversal(title: 'Data Piechart ${widget.title}'),
      body: Obx(
        () => isLoading.value
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                  horizontal: 20,
                ),
                child: ListView(
                  children: [
                    // Pie chart untuk total warga
                    PieChartWidget(
                      title: 'Jumlah Warga',
                      value1: double.parse(
                        totalData.value!.totalWarga.totalWargaLaki,
                      ),
                      label1: 'Laki-laki',
                      color1: Colors.blue,
                      value2: double.parse(
                        totalData.value!.totalWarga.totalWargaPerempuan,
                      ),
                      label2: 'Perempuan',
                      color2: Colors.red,
                    ),
                    SizedBox(height: 10),
                    // Pie chart untuk total balita
                    PieChartWidget(
                      title: 'Total Balita',
                      value1: double.parse(
                        totalData.value!.totalBalita.totalBalitaLaki,
                      ),
                      label1: 'Laki-laki',
                      color1: Colors.blue,
                      value2: double.parse(
                        totalData.value!.totalBalita.totalBalitaPerempuan,
                      ),
                      label2: 'Perempuan',
                      color2: Colors.red,
                    ),
                    SizedBox(height: 10),
                    // Pie chart untuk total warga buta
                    PieChartWidget(
                      title: 'Total Warga Buta',
                      value1: double.parse(
                        totalData.value!.totalWargaButa.totalButaLaki,
                      ),
                      label1: 'Laki-laki',
                      color1: Colors.blue,
                      value2: double.parse(
                        totalData.value!.totalWargaButa.totalButaPerempuan,
                      ),
                      label2: 'Perempuan',
                      color2: Colors.red,
                    ),
                    SizedBox(height: 10),
                    // Pie chart untuk total rumah warga
                    PieChartWidget(
                      title: 'Total Rumah Warga',
                      value1: double.parse(
                        totalData.value!.totalRumahWarga.totalRumahSehat,
                      ),
                      label1: 'Rumah Sehat',
                      color1: Colors.green,
                      value2: double.parse(
                        totalData.value!.totalRumahWarga.totalRumahTidakSehat,
                      ),
                      label2: 'Rumah Tidak Sehat',
                      color2: Colors.red,
                    ),
                    SizedBox(height: 10),
                    // Pie chart untuk total kondisi rumah
                    PieChart4LabelWidget(
                      title: 'Total Kondisi Rumah',
                      value1: double.parse(
                        totalData.value!.totalKondisiRumah.totalTempatSampah,
                      ),
                      label1: 'Tempat Sampah',
                      color1: Colors.blue,
                      value2: double.parse(
                        totalData.value!.totalKondisiRumah.totalSpal,
                      ),
                      label2: 'SPAL',
                      color2: Colors.red,
                      value3: double.parse(
                        totalData.value!.totalKondisiRumah.totalJambanKeluarga,
                      ),
                      label3: 'Jamban Keluarga',
                      color3: Colors.green,
                      value4: double.parse(
                        totalData.value!.totalKondisiRumah.totalStikerP4k,
                      ),
                      label4: 'Stiker P4K',
                      color4: Colors.orange,
                    ), // Pie chart untuk total sumber air
                    PieChart3LabelWidget(
                      title: 'Total Sumber Air',
                      value1: double.parse(
                        totalData.value!.totalSumberAir.totalPdam,
                      ),
                      label1: 'PDAM',
                      color1: Colors.blue,
                      value2: double.parse(
                        totalData.value!.totalSumberAir.totalSumur,
                      ),
                      label2: 'Sumur',
                      color2: Colors.red,
                      value3: double.parse(
                        totalData.value!.totalSumberAir.totalSungai,
                      ),
                      label3: 'Sungai',
                      color3: Colors.green,
                    ),
                    SizedBox(height: 10),

// Pie chart untuk total makanan pokok
                    PieChartWidget(
                      title: 'Total Makanan Pokok',
                      value1: double.parse(
                        totalData.value!.totalMakananPokok.totalBeras,
                      ),
                      label1: 'Beras',
                      color1: Colors.blue,
                      value2: double.parse(
                        totalData.value!.totalMakananPokok.totalNonBeras,
                      ),
                      label2: 'Non Beras',
                      color2: Colors.red,
                    ),
                    SizedBox(height: 10),

// Pie chart untuk total pemanfaatan tanah
                    PieChart6LabelWidget(
                      title: 'Total Pemanfaatan Tanah',
                      value1: double.parse(
                        totalData.value!.totalPemanfaatanTanah.totalTernak,
                      ),
                      label1: 'Ternak',
                      color1: Colors.blue,
                      value2: double.parse(
                        totalData.value!.totalPemanfaatanTanah.totalIkan,
                      ),
                      label2: 'Ikan',
                      color2: Colors.red,
                      value3: double.parse(
                        totalData.value!.totalPemanfaatanTanah.totalWarungHidup,
                      ),
                      label3: 'Warung Hidup',
                      color3: Colors.green,
                      value4: double.parse(
                        totalData
                            .value!.totalPemanfaatanTanah.totalLumbungHidup,
                      ),
                      label4: 'Lumbung Hidup',
                      color4: Colors.orange,
                      value5: double.parse(
                        totalData.value!.totalPemanfaatanTanah.totalToga,
                      ),
                      label5: 'Toga',
                      color5: Colors.purple,
                      value6: double.parse(
                        totalData
                            .value!.totalPemanfaatanTanah.totalTanamanKeras,
                      ),
                      label6: 'Tanaman Keras',
                      color6: Colors.yellow,
                    ),
                    SizedBox(height: 10),

// Pie chart untuk total ibu dan balita
                    PieChart3LabelWidget(
                      title: 'Total Ibu dan Balita',
                      value1: double.parse(
                        totalData.value!.totalIbuDanBalita.toalibuhamil,
                      ),
                      label1: 'Ibu Hamil',
                      color1: Colors.blue,
                      value2: double.parse(
                        totalData.value!.totalIbuDanBalita.totalibumenyusui,
                      ),
                      label2: 'Ibu Menyusui',
                      color2: Colors.red,
                      value3: double.parse(
                        totalData.value!.totalIbuDanBalita.totalbalita,
                      ),
                      label3: 'Balita',
                      color3: Colors.green,
                    ),
                    SizedBox(height: 10),

// Pie chart untuk total industri
                    PieChart3LabelWidget(
                      title: 'Total Industri',
                      value1: double.parse(
                        totalData.value!.totalIndustri.totalpangan,
                      ),
                      label1: 'Pangan',
                      color1: Colors.blue,
                      value2: double.parse(
                        totalData.value!.totalIndustri.totalsandang,
                      ),
                      label2: 'Sandang',
                      color2: Colors.red,
                      value3: double.parse(
                        totalData.value!.totalIndustri.totaljasa,
                      ),
                      label3: 'Jasa',
                      color3: Colors.green,
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
