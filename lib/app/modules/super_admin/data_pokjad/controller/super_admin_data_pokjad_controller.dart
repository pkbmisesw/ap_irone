import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irone/app/modules/data_pokjac/model/data_pokjac_model.dart';
import 'package:irone/app/modules/data_pokjad/model/data_pokjad_model.dart';
// ignore: unused_import
import 'package:irone/app/modules/data_rekap/models/data_rekap_models.dart';
import 'package:irone/app/modules/data_umum/model/data_umum_models.dart';
import 'package:irone/app/utils/local_db.dart';

class SuperAdminDataRekapServices extends GetxController {
  late DataUmumModel dataUmumModel;
  RxInt stepperValue = 0.obs;
  RxBool isLoading = false.obs;

  final datas = [
    'Nama Kecamatan',
    'Nama Kelurahan',
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

  void updateEditingControllers(DataPokjadModel data) {
    editingControllers[0].text = data.kecamatan_nama.toString();
    editingControllers[1].text = data.kelurahan_nama.toString();
    editingControllers[2].text = data.namaLing;
    editingControllers[3].text = data.jKPos.toString();
    editingControllers[4].text = data.jKGizi.toString();
    editingControllers[5].text = data.jKKes.toString();
    editingControllers[6].text = data.jKNar.toString();
    editingControllers[7].text = data.jKPhbs.toString();
    editingControllers[8].text = data.jKKB.toString();
    editingControllers[9].text = data.kpJumlah.toString();
    editingControllers[10].text = data.kpJumlahI.toString();
    editingControllers[11].text = data.kpLanJK.toString();
    editingControllers[12].text = data.kpLanJA.toString();
    editingControllers[13].text = data.kpLanBG.toString();
    editingControllers[14].text = data.jJamban.toString();
    editingControllers[15].text = data.jSPAL.toString();
    editingControllers[16].text = data.jSampah.toString();
    editingControllers[17].text = data.jMCK.toString();
    editingControllers[18].text = data.jKPdam.toString();
    editingControllers[19].text = data.jKSumur.toString();
    editingControllers[20].text = data.jKSungai.toString();
    editingControllers[21].text = data.jKLain.toString();
    editingControllers[22].text = data.jPus.toString();
    editingControllers[23].text = data.jWus.toString();
    editingControllers[24].text = data.jaL.toString();
    editingControllers[25].text = data.jaP.toString();
    editingControllers[26].text = data.jKK.toString();
    editingControllers[27].text = data.ket ?? "";
    editingControllers[28].text = data.status.toString();
  }
}
