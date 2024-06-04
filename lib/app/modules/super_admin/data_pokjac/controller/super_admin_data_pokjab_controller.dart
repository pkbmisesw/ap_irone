import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silahan_kawan/app/modules/data_pokjac/model/data_pokjac_model.dart';
// ignore: unused_import
import 'package:silahan_kawan/app/modules/data_rekap/models/data_rekap_models.dart';
import 'package:silahan_kawan/app/modules/data_umum/model/data_umum_models.dart';
import 'package:silahan_kawan/app/utils/local_db.dart';

class SuperAdminDataRekapServices extends GetxController {
  late DataUmumModel dataUmumModel;
  RxInt stepperValue = 0.obs;
  RxBool isLoading = false.obs;

  final datas = [
    'Nama Kecamatan',
    'Nama Kelurahan',
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

    super.onInit();
  }

  void updateEditingControllers(DataPokjacModel data) {
    editingControllers[0].text = data.kecamatan_nama.toString();
    editingControllers[1].text = data.kelurahan_nama.toString();
    editingControllers[2].text = data.namaLing;
    editingControllers[3].text = data.jKPangan.toString();
    editingControllers[4].text = data.jKSandang.toString();
    editingControllers[5].text = data.jKTaRt.toString();
    editingControllers[6].text = data.pMpBeras.toString();
    editingControllers[7].text = data.pMpNberas.toString();
    editingControllers[8].text = data.pPPTernak.toString();
    editingControllers[9].text = data.pPPIkan.toString();
    editingControllers[10].text = data.pPPWarung.toString();
    editingControllers[11].text = data.pPPLumbung.toString();
    editingControllers[12].text = data.pPPToga.toString();
    editingControllers[13].text = data.pPPTkeras.toString();
    editingControllers[14].text = data.jiPangan.toString();
    editingControllers[15].text = data.jiSandang.toString();
    editingControllers[16].text = data.jiJasa.toString();
    editingControllers[17].text = data.jrSehat.toString();
    editingControllers[18].text = data.jrTsehat.toString();
    editingControllers[19].text = data.ket ?? '';
    editingControllers[20].text = data.status.toString();
  }
}
