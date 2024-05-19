import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:irone/app/data/models/auth/login/users_model.dart';
import 'package:irone/app/utils/local_db.dart';
import 'package:http/http.dart' as http;

import '../model/data_pokjad_model.dart';

class DataPokjadInputController extends GetxController {
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
      } else if (index == 28) {
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
    'Jumlah Kader Posyandu',
    'Jumlah Kader Gizi',
    'Jumlah Kader Kesling',
    'Jumlah Kader Penyuluhan Narkoba',
    'Jumlah Kader PHBS',
    'Jumlah Kader KB',
    'Kesehatan Posyandu Jumlah',
    'Kesehatan Posyandu Terintegrasi',
    'Kesehatan Posyandu Lansia Jumlah Kelompok',
    'Kesehatan Posyandu Lansia Jumlah Anggota',
    'Kesehatan Posyandu Lansia Jumlah Memiliki Kartu',
    'Jumlah Jamban',
    'Jumlah SPAL',
    'Jumlah Tempat Pembuangan Sampah',
    'Jumlah MCK',
    'Jumlah KRT PDAM',
    'Jumlah KRT SUMUR',
    'Jumlah KRT SUNGAI',
    'Jumlah KRT Lain-Lain',
    'Jumlah PUS',
    'Jumlah WUS',
    'JUMLAH AKSEPTOR KB Laki',
    'JUMLAH AKSEPTOR KB Perempuan',
    'JUMLAH KK YANG MEMILIKI TABUNGAN',
    'Keterangan',
    'Status'
  ];

  Future<void> inputData(BuildContext context) async {
    final String namaLing = editingControllers[3].text;

    final int jKPos = int.tryParse(editingControllers[4].text) ?? 0;
    final int jKGizi = int.tryParse(editingControllers[5].text) ?? 0;
    final int jKKes = int.tryParse(editingControllers[6].text) ?? 0;
    final int jKNar = int.tryParse(editingControllers[7].text) ?? 0;
    final int jKPhbs = int.tryParse(editingControllers[8].text) ?? 0;
    final int jKKB = int.tryParse(editingControllers[9].text) ?? 0;
    final int kpJumlah = int.tryParse(editingControllers[10].text) ?? 0;
    final int kpJumlahI = int.tryParse(editingControllers[11].text) ?? 0;
    final int kpLanJK = int.tryParse(editingControllers[12].text) ?? 0;
    final int kpLanJA = int.tryParse(editingControllers[13].text) ?? 0;
    final int kpLanBG = int.tryParse(editingControllers[14].text) ?? 0;
    final int jJamban = int.tryParse(editingControllers[15].text) ?? 0;
    final int jSPAL = int.tryParse(editingControllers[16].text) ?? 0;
    final int jSampah = int.tryParse(editingControllers[17].text) ?? 0;
    final int jMCK = int.tryParse(editingControllers[18].text) ?? 0;
    final int jKPdam = int.tryParse(editingControllers[19].text) ?? 0;
    final int jKSumur = int.tryParse(editingControllers[20].text) ?? 0;
    final int jKSungai = int.tryParse(editingControllers[21].text) ?? 0;
    final int jKLain = int.tryParse(editingControllers[22].text) ?? 0;
    final int jPus = int.tryParse(editingControllers[23].text) ?? 0;
    final int jWus = int.tryParse(editingControllers[24].text) ?? 0;
    final int jaL = int.tryParse(editingControllers[25].text) ?? 0;
    final int jaP = int.tryParse(editingControllers[26].text) ?? 0;
    final int jKK = int.tryParse(editingControllers[27].text) ?? 0;
    final String? ket = editingControllers[28].text;
    final int status = int.tryParse(editingControllers[29].text) ?? 0;

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

    DataPokjadModel dataPokjadModels = DataPokjadModel(
      idKel: idKel,
      idKec: idKec,
      namaLing: namaLing,
      jKPos: jKPos,
      jKGizi: jKGizi,
      jKKes: jKKes,
      jKNar: jKNar,
      jKPhbs: jKPhbs,
      jKKB: jKKB,
      kpJumlah: kpJumlah,
      kpJumlahI: kpJumlahI,
      kpLanJK: kpLanJK,
      kpLanJA: kpLanJA,
      kpLanBG: kpLanBG,
      jJamban: jJamban,
      jSPAL: jSPAL,
      jSampah: jSampah,
      jMCK: jMCK,
      jKPdam: jKPdam,
      jKSumur: jKSumur,
      jKSungai: jKSungai,
      jKLain: jKLain,
      jPus: jPus,
      jWus: jWus,
      jaL: jaL,
      jaP: jaP,
      jKK: jKK,
      ket: ket,
      status: status,
    );

    if (idKec == 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBarWidget('Field tidak boleh kosong'));
    } else {
      try {
        isLoading.value = true;
        final DataPokjadModel body = dataPokjadModels;

        final response = await http.post(
          Uri.parse("https://app2.tppkk-bitung.com/api/add-data-pokjad"),
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
