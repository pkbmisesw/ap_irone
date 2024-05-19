import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:irone/app/data/models/auth/login/users_model.dart';
import 'package:irone/app/utils/local_db.dart';
import 'package:http/http.dart' as http;

import '../models/data_pokja_model.dart';

class DataPokjaInputController extends GetxController {
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
    'ID',
    'ID Kecamatan',
    'ID Kelurahan',
    'Nama Lingkungan',
    'Jumlah PKBN',
    'Jumlah PKDRT',
    'Pola Asuh',
    'P PKBN Simulasi',
    'P PKBN Anggota',
    'P PKDRT Simulasi',
    'P PKDRT Anggota',
    'Pola Kelompok',
    'Pola Anggota',
    'Lansia Kelompok',
    'Lansia Anggota',
    'Gotong Royong Jumlah Kerja Bakti',
    'Gotong Royong Jumlah Rukung Kematian',
    'Gotong Royong Jumlah Keagamaan',
    'Gotong Royong Jumlah Jimpitan',
    'Gotong Royong Jumlah Arisan',
    'Keterangan',
    'Status',
  ];

  Future<void> inputData(BuildContext context) async {
    final String namaLing = editingControllers[3].text;
    final int jPkbn = int.tryParse(editingControllers[4].text) ?? 0;
    final int jPkdrt = int.tryParse(editingControllers[5].text) ?? 0;
    final int pola = int.tryParse(editingControllers[6].text) ?? 0;
    final int pPkbnSim = int.tryParse(editingControllers[7].text) ?? 0;
    final int pPkbnAnggota = int.tryParse(editingControllers[8].text) ?? 0;
    final int pPkdrtSim = int.tryParse(editingControllers[9].text) ?? 0;
    final int pPkdrtAnggota = int.tryParse(editingControllers[10].text) ?? 0;
    final int polaKel = int.tryParse(editingControllers[11].text) ?? 0;
    final int polaAnggota = int.tryParse(editingControllers[12].text) ?? 0;
    final int lansiaKel = int.tryParse(editingControllers[13].text) ?? 0;
    final int lansiaAnggota = int.tryParse(editingControllers[14].text) ?? 0;
    final int gJumKer = int.tryParse(editingControllers[15].text) ?? 0;
    final int gJumRuk = int.tryParse(editingControllers[16].text) ?? 0;
    final int gJumAgama = int.tryParse(editingControllers[17].text) ?? 0;
    final int gJumJimpit = int.tryParse(editingControllers[18].text) ?? 0;
    final int gJumArisan = int.tryParse(editingControllers[19].text) ?? 0;
    final String ket = editingControllers[20].text;
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

    DataPokjaModel dataPokjaModels = DataPokjaModel(
      idKel: idKel,
      idKec: idKec,
      namaLing: namaLing,
      jPkbn: jPkbn,
      jPkdrt: jPkdrt,
      pola: pola,
      pPkbnSim: pPkbnSim,
      pPkbnAnggota: pPkbnAnggota,
      pPkdrtSim: pPkdrtSim,
      pPkdrtAnggota: pPkdrtAnggota,
      polaKel: polaKel,
      polaAnggota: polaAnggota,
      lansiaKel: lansiaKel,
      lansiaAnggota: lansiaAnggota,
      gJumKer: gJumKer,
      gJumRuk: gJumRuk,
      gJumAgama: gJumAgama,
      gJumJimpit: gJumJimpit,
      gJumArisan: gJumArisan,
      ket: ket,
      status: status,
    );

    if (idKec == 0) {
      ScaffoldMessenger.of(context)
          .showSnackBar(snackBarWidget('Field tidak boleh kosong'));
    } else {
      try {
        isLoading.value = true;
        final DataPokjaModel body = dataPokjaModels;

        final response = await http.post(
          Uri.parse("https://app2.tppkk-bitung.com/api/add-data-pokjaa"),
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
