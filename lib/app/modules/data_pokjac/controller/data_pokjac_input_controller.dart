import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:silahan_kawan/app/data/models/auth/login/users_model.dart';
import 'package:silahan_kawan/app/utils/local_db.dart';
import 'package:http/http.dart' as http;

import '../model/data_pokjac_model.dart';

class DataPokjacInputController extends GetxController {
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
      } else if (index == 20) {
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
    'Jumlah Kader Pangan',
    'Jumlah Kader Sandang',
    'Jumlah Kader Tata Laksana Rumah Tangga',
    'Pangan Makanan Pokok Beras',
    'Pangan Makanan Pokok Non Beras',
    'Pangan Pemanfaatan Pekarangan Peternakan',
    'Pangan Pemanfaatan Pekarangan Perikanan',
    'Pangan Pemanfaatan Pekarangan Warung Hidup',
    'Pangan Pemanfaatan Pekarangan Lumbung Hidup',
    'Pangan Pemanfaatan Pekarangan Toga',
    'Pangan Pemanfaatan Pekarangan Tanaman Keras',
    'Jumlah Industri Pangan',
    'Jumlah Industri Sandang',
    'Jumlah Industri Jasa',
    'Jumlah Rumah Sehat',
    'Jumlah Rumah Tidak Sehat',
    'Keterangan',
    'Status'
  ];

  Future<void> inputData(BuildContext context) async {
    final String namaLing = editingControllers[3].text;

    final int jKPangan = int.tryParse(editingControllers[4].text) ?? 0;
    final int jKSandang = int.tryParse(editingControllers[5].text) ?? 0;
    final int jKTaRt = int.tryParse(editingControllers[6].text) ?? 0;
    final int pMpBeras = int.tryParse(editingControllers[7].text) ?? 0;
    final int pMpNberas = int.tryParse(editingControllers[8].text) ?? 0;
    final int pPPTernak = int.tryParse(editingControllers[9].text) ?? 0;
    final int pPPIkan = int.tryParse(editingControllers[10].text) ?? 0;
    final int pPPWarung = int.tryParse(editingControllers[11].text) ?? 0;
    final int pPPLumbung = int.tryParse(editingControllers[12].text) ?? 0;
    final int pPPToga = int.tryParse(editingControllers[13].text) ?? 0;
    final int pPPTkeras = int.tryParse(editingControllers[14].text) ?? 0;
    final int jiPangan = int.tryParse(editingControllers[15].text) ?? 0;
    final int jiSandang = int.tryParse(editingControllers[16].text) ?? 0;
    final int jiJasa = int.tryParse(editingControllers[17].text) ?? 0;
    final int jrSehat = int.tryParse(editingControllers[18].text) ?? 0;
    final int jrTsehat = int.tryParse(editingControllers[19].text) ?? 0;
    final String? ket = editingControllers[20].text;
    final int status = int.tryParse(editingControllers[21].text) ?? 0;

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

    DataPokjacModel dataPokjacModels = DataPokjacModel(
      idKel: idKel,
      idKec: idKec,
      namaLing: namaLing,
      jKPangan: jKPangan,
      jKSandang: jKSandang,
      jKTaRt: jKTaRt,
      pMpBeras: pMpBeras,
      pMpNberas: pMpNberas,
      pPPTernak: pPPTernak,
      pPPIkan: pPPIkan,
      pPPWarung: pPPWarung,
      pPPLumbung: pPPLumbung,
      pPPToga: pPPToga,
      pPPTkeras: pPPTkeras,
      jiPangan: jiPangan,
      jiSandang: jiSandang,
      jiJasa: jiJasa,
      jrSehat: jrSehat,
      jrTsehat: jrTsehat,
      ket: ket,
      status: status,
    );

    if (idKec == 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBarWidget('Field tidak boleh kosong'));
    } else {
      try {
        isLoading.value = true;
        final DataPokjacModel body = dataPokjacModels;

        final response = await http.post(
          Uri.parse("https://app2.tppkk-bitung.com/api/add-data-pokjac"),
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
