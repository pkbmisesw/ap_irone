import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irone/app/modules/data_pokjaa/models/data_pokja_model.dart';
// ignore: unused_import
import 'package:irone/app/modules/data_rekap/models/data_rekap_models.dart';
import 'package:irone/app/modules/data_umum/model/data_umum_models.dart';
import 'package:irone/app/utils/local_db.dart';

class SuperAdminDataPokjaaServices extends GetxController {
  late DataUmumModel dataUmumModel;
  RxInt stepperValue = 0.obs;
  RxBool isLoading = false.obs;

  final datas = [
    'Nama Kecamatan',
    'Nama Kelurahan',
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

  final editingControllers = <TextEditingController>[];
  final keyboardTypes = <TextInputType>[];
  final formKey = GlobalKey<FormState>();
  final loadingBtn = false.obs;
  final canEdit = false.obs;

  @override
  onInit() {
    editingControllers.assignAll(
        List.generate(datas.length, (index) => TextEditingController()));
    editingControllers.first.text = LocalDb.credential.users?.idKel != null
        ? LocalDb.credential.users!.idKel.toString()
        : "";

    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.text);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);

    keyboardTypes.add(TextInputType.text);

    super.onInit();
  }

  void updateEditingControllers(DataPokjaModel data) {
    editingControllers[0].text = data.kecamatan_nama.toString();
    editingControllers[1].text = data.kelurahan_nama.toString();
    editingControllers[2].text = data.namaLing;
    editingControllers[3].text = data.jPkbn.toString();
    editingControllers[4].text = data.jPkdrt.toString();
    editingControllers[5].text = data.pola.toString();
    editingControllers[6].text = data.pPkbnSim.toString();
    editingControllers[7].text = data.pPkbnAnggota.toString();
    editingControllers[8].text = data.pPkdrtSim.toString();
    editingControllers[9].text = data.pPkdrtAnggota.toString();
    editingControllers[10].text = data.polaKel.toString();
    editingControllers[11].text = data.polaAnggota.toString();
    editingControllers[12].text = data.lansiaKel.toString();
    editingControllers[13].text = data.lansiaAnggota.toString();
    editingControllers[14].text = data.gJumKer.toString();
    editingControllers[15].text = data.gJumRuk.toString();
    editingControllers[16].text = data.gJumAgama.toString();
    editingControllers[17].text = data.gJumJimpit.toString();
    editingControllers[18].text = data.gJumArisan.toString();
    editingControllers[19].text = data.ket.toString();
    editingControllers[20].text = data.status.toString();
  }
}
