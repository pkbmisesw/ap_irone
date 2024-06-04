import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:silahan_kawan/app/data/models/auth/login/users_model.dart';
import 'package:silahan_kawan/app/modules/data_umum/model/data_umum_models.dart';
import 'package:silahan_kawan/app/utils/local_db.dart';
import 'package:http/http.dart' as http;

class DataUmumInputController extends GetxController {
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
      stepperButtonText.value = 'Submit';
      stepperBUttonCancel.value = 'Previous';
    } else if (value == 2) {
      stepperBUttonCancel.value = 'Previous';
      stepperButtonText.value = 'Finish';
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
    editingControllers.first.text = LocalDb.credential.users?.idKel != null
        ? LocalDb.credential.users!.idKel.toString()
        : "";
    keyboardTypes.addAll([
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
      TextInputFormatter.withFunction((oldValue, newValue) {
        return newValue.text.isEmpty ||
                RegExp(r'^[a-zA-Z0-9]+$').hasMatch(newValue.text)
            ? newValue
            : oldValue;
      }),
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
      FilteringTextInputFormatter.digitsOnly,
      TextInputFormatter.withFunction((oldValue, newValue) {
        // Allow any characters for 'ket'
        return newValue;
      }),
      FilteringTextInputFormatter.digitsOnly,
    ]);

    editingControllers[0].text = data?.idKec.toString() ?? 0.toString();
    editingControllers[1].text = data?.idKel.toString() ?? 0.toString();

    super.onInit();
  }

  final datas = [
    "ID",
    "ID Kecamatan",
    "ID Kelurahan",
    "No Urut",
    "Nama Lingkungan",
    "Pkk RW",
    "PKK RT",
    "Dasawisma",
    "Kepala Rumah Tangga",
    "Kepala Keluarga",
    "Jumlah Jiwa Laki",
    "Jumlah Jiwa Perempuan",
    "Anggota TP PKK Laki",
    "Anggota TP PKK Perempuan",
    "Kader Umum Laki",
    "Kader Umum Perempuan",
    "Kader Khusus Laki",
    "Kader Khusus Perempuan",
    "JUMLAH TENAGA SEKRETARIAT Honorer Laki",
    "JUMLAH TENAGA SEKRETARIAT Honorer Perempuan",
    "JUMLAH TENAGA SEKRETARIAT Bantuan Laki",
    "JUMLAH TENAGA SEKRETARIAT Bantuan Perempuan",
    "Keterangan",
    "Status",
  ];

  Future<void> inputData(BuildContext context) async {
    final String namaLing = editingControllers[4].text;
    final int pRw = int.tryParse(editingControllers[5].text) ?? 0;
    final int pRt = int.tryParse(editingControllers[6].text) ?? 0;
    final int dasa = int.tryParse(editingControllers[7].text) ?? 0;
    final int kRumah = int.tryParse(editingControllers[8].text) ?? 0;
    final int kk = int.tryParse(editingControllers[9].text) ?? 0;
    final int jLaki = int.tryParse(editingControllers[10].text) ?? 0;
    final int jPerempuan = int.tryParse(editingControllers[11].text) ?? 0;
    final int aLaki = int.tryParse(editingControllers[12].text) ?? 0;
    final int aPerempuan = int.tryParse(editingControllers[13].text) ?? 0;
    final int uLaki = int.tryParse(editingControllers[14].text) ?? 0;
    final int uPerempuan = int.tryParse(editingControllers[15].text) ?? 0;
    final int kLaki = int.tryParse(editingControllers[16].text) ?? 0;
    final int kPerempuan = int.tryParse(editingControllers[17].text) ?? 0;
    final int hLaki = int.tryParse(editingControllers[18].text) ?? 0;
    final int hPerempuan = int.tryParse(editingControllers[19].text) ?? 0;
    final int bLaki = int.tryParse(editingControllers[20].text) ?? 0;
    final int bPerempuan = int.tryParse(editingControllers[21].text) ?? 0;
    final String ket = editingControllers[22].text;
    final int status = int.tryParse(editingControllers[23].text) ?? 0;

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

    DataUmumModel dataUmumModels = DataUmumModel(
      idKel: idKel,
      idKec: idKec,
      namaLing: namaLing,
      pRw: pRw,
      pRt: pRt,
      dasa: dasa,
      kRumah: kRumah,
      kk: kk,
      jLaki: jLaki,
      jPerempuan: jPerempuan,
      aLaki: aLaki,
      aPerempuan: aPerempuan,
      uLaki: uLaki,
      uPerempuan: uPerempuan,
      kLaki: kLaki,
      kPerempuan: kPerempuan,
      hLaki: hLaki,
      hPerempuan: hPerempuan,
      bLaki: bLaki,
      bPerempuan: bPerempuan,
      ket: ket,
      status: status,
    );

    if (idKec == 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBarWidget('Field tidak boleh kosong'));
    } else {
      try {
        isLoading.value = true;
        final DataUmumModel body = dataUmumModels;

        final response = await http.post(
          Uri.parse("https://app2.tppkk-bitung.com/api/add-data-umum"),
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'},
        );
        print(response.body);
        print(body);
        if (response.statusCode == 200) {
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBarWidget('Sukses Simpan Data'));
        } else if (response.statusCode == 400) {
          ScaffoldMessenger.of(context)
              .showSnackBar(snackBarWidget('Gagal Simpan Data'));
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
