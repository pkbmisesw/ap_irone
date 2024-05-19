import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irone/app/data/models/auth/login/users_model.dart';
import 'package:irone/app/utils/local_db.dart';
import 'package:http/http.dart' as http;
import '../models/data_rekap_models.dart';

class DataRekapInputController extends GetxController {
  RxInt stepperValue = 0.obs;
  RxBool isLoading = false.obs;
  int idKel = 0; // Nilai awal
  int idKec = 0; // Nilai awal

  final idKecController = TextEditingController();
  final idKelController = TextEditingController();
  final namaLingController = TextEditingController();
  final editingControllers = <TextEditingController>[];

  RxString stepperButtonText = 'Next'.obs;
  RxString stepperBUttonCancel = 'Cancel'.obs;

  void updateStepperValue(int value) {
    if (value == 0) {
      stepperButtonText.value = 'Next';
      stepperBUttonCancel.value = 'Cancel';
    } else if (value == 1) {
      stepperButtonText.value = 'Next';
      stepperBUttonCancel.value = 'Previous';
    } else if (value == 2) {
      stepperBUttonCancel.value = 'Previous';
      stepperButtonText.value = 'Simpan';
    } else if (value == 3) {
      stepperBUttonCancel.value = 'Reset';
      stepperButtonText.value = 'Finish';
    }
  }

  void updateStepperCancel(int value) {
    if (value == 1) {
      value = 0;
    } else if (value == 2) {
      value = 1;
    }
  }

  String getStepperButtonText(int stepperValue) {
    if (stepperValue == 1 || stepperValue == 2) {
      return 'Next';
    } else if (stepperValue == 3) {
      return 'Simpan';
    } else {
      return ''; // Atur nilai kembali sesuai dengan kebutuhan Anda
    }
  }

  @override
  void onInit() {
    UsersModel? data =
        LocalDb.credential.users != null ? LocalDb.credential.users : null;

    idKec = data?.idKec ?? 0;
    idKel = data?.idKel ?? 0;

    editingControllers.assignAll(
        List.generate(datas.length, (index) => TextEditingController()));
    editingControllers[0].text = data?.idKec.toString() ?? 0.toString();
    editingControllers[1].text = data?.idKel.toString() ?? 0.toString();

    super.onInit();
  }

  final datas = [
    "ID Kecamatan",
    "ID Kelurahan",
    "Nama Lingkungan",
    "Jumlah RW",
    "Jumlah RT",
    "Jumlah Dasa wisma",
    "Jumlah Kepala Rumah Tangga",
    "Jumlah KK",
    "Jumlah Anggota Keluarga Total Laki-laki",
    "Jumlah Anggota Keluarga Total Perempuan",
    "Jumlah Balita Keluarga Total Laki-laki",
    "Jumlah Balita Keluarga Total Perempuan",
    "Jumlah Anggota Keluarga PUS",
    "Jumlah Anggota Keluarga WUS",
    "Jumlah Anggota Keluarga Ibu Hamil",
    "Jumlah Anggota Keluarga Ibu menyusui",
    "Jumlah Anggota Keluarga Lansia",
    "Jumlah Anggota Keluarga 3 Buta Laki-laki",
    "Jumlah Anggota Keluarga 3 Buta Perempuan",
    "Jumlah Anggota Keluarga Berkebutuhan khusus",
    "Kriteria Rumah Sehat",
    "Kriteria Rumah Tidak Sehat",
    "Jumlah Rumah memiliki Tj_rw Pembuangan Sampah",
    "Jumlah Rumah memiliki SPAL",
    "Jumlah Rumah memiliki Jamban Keluarga",
    "Jumlah Rumah memiliki Stiker P4K",
    "Sumber Air Keluarga Pdam",
    "Sumber Air Keluarga Sumur",
    "Sumber Air Keluarga Sungai",
    "Sumber Air Keluarga DLL",
    "Makanan Pokok Beras",
    "Makanan Pokok Non Beras",
    "Jumlah KK Yang memiliki tabung",
    "Keluarga Mengikuti Kegiatan UP2K",
    "Keluarga Mengikuti Kegiatan Pemanfaatan Peternakan",
    "Keluarga Mengikuti Kegiatan Pemanfaatan Perikanan",
    "Keluarga Mengikuti Kegiatan Pemanfaatan Warung Hidup",
    "Keluarga Mengikuti Kegiatan Pemanfaatan Lumbung Hidup",
    "Keluarga Mengikuti Kegiatan Pemanfaatan Toga",
    "Keluarga Mengikuti Kegiatan Tanaman Keras",
    "Keluarga Mengikuti Kegiatan Industri Pangan",
    "Keluarga Mengikuti Kegiatan Industri Sandang",
    "Keluarga Mengikuti Kegiatan Industri Jasa",
    "Keluarga Mengikuti Kegiatan Kesehatan Lingkungan",
    "Keterangan",
  ];

  Future<void> inputData(BuildContext context) async {
    final namaLing = editingControllers[2].text;
    final jRw = int.tryParse(editingControllers[3].text) ?? 0;
    final jRt = int.tryParse(editingControllers[4].text) ?? 0;
    final jDasawisma = int.tryParse(editingControllers[5].text) ?? 0;
    final jKrt = int.tryParse(editingControllers[6].text) ?? 0;
    final jKk = int.tryParse(editingControllers[7].text) ?? 0;
    final jATotalL = int.tryParse(editingControllers[8].text) ?? 0;
    final jATotalP = int.tryParse(editingControllers[9].text) ?? 0;
    final jABalitaL = int.tryParse(editingControllers[10].text) ?? 0;
    final jABalitaP = int.tryParse(editingControllers[11].text) ?? 0;
    final jAPus = int.tryParse(editingControllers[12].text) ?? 0;
    final jAWus = int.tryParse(editingControllers[13].text) ?? 0;
    final jAHamil = int.tryParse(editingControllers[14].text) ?? 0;
    final jASusui = int.tryParse(editingControllers[15].text) ?? 0;
    final jALansia = int.tryParse(editingControllers[16].text) ?? 0;
    final jABlaki = int.tryParse(editingControllers[17].text) ?? 0;
    final jABcwe = int.tryParse(editingControllers[18].text) ?? 0;
    final jABb = int.tryParse(editingControllers[19].text) ?? 0;
    final krSehat = int.tryParse(editingControllers[20].text) ?? 0;
    final krTdkSehat = int.tryParse(editingControllers[21].text) ?? 0;
    final jrTsampah = int.tryParse(editingControllers[22].text) ?? 0;
    final jrSpal = int.tryParse(editingControllers[23].text) ?? 0;
    final jrJamban = int.tryParse(editingControllers[24].text) ?? 0;
    final jrStiker = int.tryParse(editingControllers[25].text) ?? 0;
    final sakPdam = int.tryParse(editingControllers[26].text) ?? 0;
    final sakSumur = int.tryParse(editingControllers[27].text) ?? 0;
    final sakSungai = int.tryParse(editingControllers[28].text) ?? 0;
    final sakDll = int.tryParse(editingControllers[29].text) ?? 0;
    final mpBeras = int.tryParse(editingControllers[30].text) ?? 0;
    final mpNonberas = int.tryParse(editingControllers[31].text) ?? 0;
    final jkkTabung = int.tryParse(editingControllers[32].text) ?? 0;
    final kUpk = int.tryParse(editingControllers[33].text) ?? 0;
    final kpTernak = int.tryParse(editingControllers[34].text) ?? 0;
    final kpIkan = int.tryParse(editingControllers[35].text) ?? 0;
    final kpWarung = int.tryParse(editingControllers[36].text) ?? 0;
    final kpLumbung = int.tryParse(editingControllers[37].text) ?? 0;
    final kpToga = int.tryParse(editingControllers[38].text) ?? 0;
    final kpTanaman = int.tryParse(editingControllers[39].text) ?? 0;
    final iPangan = int.tryParse(editingControllers[40].text) ?? 0;
    final iSandang = int.tryParse(editingControllers[41].text) ?? 0;
    final iJasa = int.tryParse(editingControllers[42].text) ?? 0;
    final kesLing = int.tryParse(editingControllers[43].text) ?? 0;
    final ket = editingControllers[44].text;

    snackBarWidget(String text) {
      return SnackBar(
        content: Text(text),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.teal,
        action: SnackBarAction(
          label: 'Dismiss',
          textColor: Colors.white,
          onPressed: () {},
        ),
      );
    }

    DataRekapModels dataRekapModels = DataRekapModels(
      idKel: idKel,
      namaLing: namaLing,
      idKec: idKec,
      jRw: jRw,
      jRt: jRt,
      jDasawisma: jDasawisma,
      jKrt: jKrt,
      jKk: jKk,
      jATotalL: jATotalL,
      jATotalP: jATotalP,
      jABalitaL: jABalitaL,
      jABalitaP: jABalitaP,
      jAPus: jAPus,
      jAWus: jAWus,
      jAHamil: jAHamil,
      jASusui: jASusui,
      jALansia: jALansia,
      jABlaki: jABlaki,
      jABcwe: jABcwe,
      jABb: jABb,
      krSehat: krSehat,
      krTdkSehat: krTdkSehat,
      jrTsampah: jrTsampah,
      jrSpal: jrSpal,
      jrJamban: jrJamban,
      jrStiker: jrStiker,
      sakPdam: sakPdam,
      sakSumur: sakSumur,
      sakSungai: sakSungai,
      sakDll: sakDll,
      mpBeras: mpBeras,
      mpNonberas: mpNonberas,
      jkkTabung: jkkTabung,
      kUpk: kUpk,
      kpTernak: kpTernak,
      kpIkan: kpIkan,
      kpWarung: kpWarung,
      kpLumbung: kpLumbung,
      kpToga: kpToga,
      kpTanaman: kpTanaman,
      iPangan: iPangan,
      iSandang: iSandang,
      iJasa: iJasa,
      kesLing: kesLing,
      ket: ket,
    );

    if (idKec == 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBarWidget('Field tidak boleh kosong'));
    } else {
      try {
        isLoading.value = true;
        final DataRekapModels body = dataRekapModels;

        final response = await http.post(
          Uri.parse("https://app2.tppkk-bitung.com/api/add-barang-rekap"),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'},
        );
        print(response.body);
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBarWidget('Sukses Simpan Data'));
        } else if (response.statusCode == 400) {
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBarWidget('Gagal Simpan Data'));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBarWidget('Something Error'));
        }
      } catch (e) {
        print(e);
      } finally {
        isLoading.value = false;
      }
    }
  }
}
