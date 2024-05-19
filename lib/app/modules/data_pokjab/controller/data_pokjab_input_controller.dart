import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:irone/app/data/models/auth/login/users_model.dart';
import 'package:irone/app/utils/local_db.dart';
import 'package:http/http.dart' as http;

import '../models/data_pokjab_model.dart';

class DataPokjabInputController extends GetxController {
  RxInt stepperValue = 0.obs;
  RxBool isLoading = false.obs;
  int idKel = 0; // Nilai awal
  int idKec = 0; // Nilai awal

  final idKecController = TextEditingController();
  final idKelController = TextEditingController();
  final namaLingController = TextEditingController();
  final editingControllers = <TextEditingController>[];
  final keyboardTypes = <TextInputFormatter>[];

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
      stepperButtonText.value = 'Submit';
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
    } else if (value == 3) {
      value = 0;
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
    editingControllers.first.text = LocalDb.credential.users?.idKel != null
        ? LocalDb.credential.users!.idKel.toString()
        : "";
    keyboardTypes.addAll(List.generate(datas.length, (index) {
      if (index == 3) {
        return TextInputFormatter.withFunction((oldValue, newValue) {
          return newValue.text.isEmpty ||
                  RegExp(r'^[a-zA-Z0-9]+$').hasMatch(newValue.text)
              ? newValue
              : oldValue;
        });
      } else if (index == 38) {
        return TextInputFormatter.withFunction((oldValue, newValue) {
          // Allow any characters for 'ket'
          return newValue;
        });
      } else {
        return FilteringTextInputFormatter.digitsOnly;
      }
    }));

    editingControllers[0].text = data?.idKec.toString() ?? 0.toString();
    editingControllers[1].text = data?.idKel.toString() ?? 0.toString();

    super.onInit();
  }

  final datas = [
    'ID',
    'ID Kecamatan',
    'ID Kelurahan',
    'Nama Lingkungan',
    'JUMLAH WARGA YANG MASIH 3 BUTA	Laki',
    'JUMLAH WARGA YANG MASIH 3 BUTA	Perempuan',
    'Jumlah Paket A Kel. Belajar',
    'Jumlah Paket A Warga Belajar',
    'Jumlah Paket B Kel. Belajar',
    'Jumlah Paket B Warga Belajar',
    'Jumlah Paket C Kel. Belajar',
    'Jumlah Paket C Warga Belajar',
    'Jumlah KF Belajar',
    'Jumlah Kj Warga Belajar',
    'Jumlah Paud Sejenis',
    'Jumlah Taman Baca Perpus',
    'Jumlah BKB Kelompok',
    'Jumlah BKB Ibu Peserta',
    'Jumlah BKB Ape(SET)',
    'Jumlah BKB Kel Simulasi',
    'Jumlah Kader Tutor KF',
    'Jumlah Kader Tutor Paud',
    'Jumlah kader BKB',
    'Jumlah Kader Koperasi',
    'Jumlah Kader Keterampilan',
    'Jumlah Kader Latih LP3PKK',
    'Jumlah Kader Latih TP3PKK',
    'Jumlah Kader Latih Damas PKK',
    'Pengembangan Koperasi Pemula Kelompok',
    'Pengembangan Koperasi Pemula Peserta',
    'Pengembangan Koperasi Madya Kelompok',
    'Pengembangan Koperasi Madya Peserta',
    'Pengembangan Koperasi Utama Kelompok',
    'Pengembangan Koperasi Utama Peserta',
    'Pengembangan Koperasi Mandiri Kelompok',
    'Pengembangan Koperasi Mandiri Peserta',
    'Koperasi Badan Hukum Jumlah Kelompok',
    'Koperasi Badan Hukum Jumlah Peserta',
    'Keterangan',
    'Status'
  ];

  Future<void> inputData(BuildContext context) async {
    final String namaLing = editingControllers[3].text;
    final int jWmL = int.tryParse(editingControllers[4].text) ?? 0;
    final int jWmP = int.tryParse(editingControllers[5].text) ?? 0;
    final int jABel = int.tryParse(editingControllers[6].text) ?? 0;
    final int jAWBel = int.tryParse(editingControllers[7].text) ?? 0;
    final int jBBel = int.tryParse(editingControllers[8].text) ?? 0;
    final int jBWBel = int.tryParse(editingControllers[9].text) ?? 0;
    final int jCBel = int.tryParse(editingControllers[10].text) ?? 0;
    final int jCWBel = int.tryParse(editingControllers[11].text) ?? 0;
    final int jKfBel = int.tryParse(editingControllers[12].text) ?? 0;
    final int jKfWBel = int.tryParse(editingControllers[13].text) ?? 0;
    final int jPaudSJenis = int.tryParse(editingControllers[14].text) ?? 0;
    final int jTbmPer = int.tryParse(editingControllers[15].text) ?? 0;
    final int jBkbKel = int.tryParse(editingControllers[16].text) ?? 0;
    final int jBkbIbu = int.tryParse(editingControllers[17].text) ?? 0;
    final int jBkbApe = int.tryParse(editingControllers[18].text) ?? 0;
    final int jBkbSim = int.tryParse(editingControllers[19].text) ?? 0;
    final int jKtKf = int.tryParse(editingControllers[20].text) ?? 0;
    final int jKtPaud = int.tryParse(editingControllers[21].text) ?? 0;
    final int jKBkb = int.tryParse(editingControllers[22].text) ?? 0;
    final int jKKop = int.tryParse(editingControllers[23].text) ?? 0;
    final int jKKet = int.tryParse(editingControllers[24].text) ?? 0;
    final int jKLlpt = int.tryParse(editingControllers[25].text) ?? 0;
    final int jKLtpk = int.tryParse(editingControllers[26].text) ?? 0;
    final int jKLdamas = int.tryParse(editingControllers[27].text) ?? 0;
    final int pKopPemKel = int.tryParse(editingControllers[28].text) ?? 0;
    final int pKopPemPes = int.tryParse(editingControllers[29].text) ?? 0;
    final int pKopMadKel = int.tryParse(editingControllers[30].text) ?? 0;
    final int pKopMadPes = int.tryParse(editingControllers[31].text) ?? 0;
    final int pKopUtKel = int.tryParse(editingControllers[32].text) ?? 0;
    final int pKopMutPes = int.tryParse(editingControllers[33].text) ?? 0;
    final int pKopManKel = int.tryParse(editingControllers[34].text) ?? 0;
    final int pKopManPes = int.tryParse(editingControllers[35].text) ?? 0;
    final int kJKel = int.tryParse(editingControllers[36].text) ?? 0;
    final int kJPes = int.tryParse(editingControllers[37].text) ?? 0;
    final String? ket = editingControllers[38].text;
    final int status = int.tryParse(editingControllers[39].text) ?? 0;

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

    DataPokjabModel dataPokjabModels = DataPokjabModel(
      idKel: idKel,
      idKec: idKec,
      namaLing: namaLing,
      jWmL: jWmL,
      jWmP: jWmP,
      jABel: jABel,
      jAWBel: jAWBel,
      jBBel: jBBel,
      jBWBel: jBWBel,
      jCBel: jCBel,
      jCWBel: jCWBel,
      jKfBel: jKfBel,
      jKfWBel: jKfWBel,
      jPaudSJenis: jPaudSJenis,
      jTbmPer: jTbmPer,
      jBkbKel: jBkbKel,
      jBkbIbu: jBkbIbu,
      jBkbApe: jBkbApe,
      jBkbSim: jBkbSim,
      jKtKf: jKtKf,
      jKtPaud: jKtPaud,
      jKBkb: jKBkb,
      jKKop: jKKop,
      jKKet: jKKet,
      jKLlpt: jKLlpt,
      jKLtpk: jKLtpk,
      jKLdamas: jKLdamas,
      pKopPemKel: pKopPemKel,
      pKopPemPes: pKopPemPes,
      pKopMadKel: pKopMadKel,
      pKopMadPes: pKopMadPes,
      pKopUtKel: pKopUtKel,
      pKopMutPes: pKopMutPes,
      pKopManKel: pKopManKel,
      pKopManPes: pKopManPes,
      kJKel: kJKel,
      kJPes: kJPes,
      ket: ket,
      status: status,
    );

    if (idKec == 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBarWidget('Field tidak boleh kosong'));
    } else {
      try {
        isLoading.value = true;
        final DataPokjabModel body = dataPokjabModels;

        final response = await http.post(
          Uri.parse("https://app2.tppkk-bitung.com/api/add-data-pokjab"),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'},
        );
        print(response.body);
        print(body);
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBarWidget('Sukses Submit Data'));
        } else if (response.statusCode == 400) {
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBarWidget('Gagal Submit Data'));
        } else if (response.statusCode == 404) {
          stepperValue.value = 0;
          updateStepperValue(stepperValue.value);
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBarWidget('Nama Lingkungan Sudah Digunakan'));
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
