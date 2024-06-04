import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silahan_kawan/app/modules/data_pokjab/models/data_pokjab_model.dart';
// ignore: unused_import
import 'package:silahan_kawan/app/modules/data_rekap/models/data_rekap_models.dart';
import 'package:silahan_kawan/app/modules/data_umum/model/data_umum_models.dart';
import 'package:silahan_kawan/app/utils/local_db.dart';

class SuperAdminDataPokjabServices extends GetxController {
  late DataUmumModel dataUmumModel;
  RxInt stepperValue = 0.obs;
  RxBool isLoading = false.obs;

  final datas = [
    'Nama Kecamatan',
    'Nama Kelurahan',
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

  void updateEditingControllers(DataPokjabModel data) {
    editingControllers[0].text = data.kecamatan_nama.toString();
    editingControllers[1].text = data.kelurahan_nama.toString();
    editingControllers[2].text = data.namaLing;
    editingControllers[3].text = data.jWmL.toString();
    editingControllers[4].text = data.jWmP.toString();
    editingControllers[5].text = data.jABel.toString();
    editingControllers[6].text = data.jAWBel.toString();
    editingControllers[7].text = data.jBBel.toString();
    editingControllers[8].text = data.jBWBel.toString();
    editingControllers[9].text = data.jCBel.toString();
    editingControllers[10].text = data.jCWBel.toString();
    editingControllers[11].text = data.jKfBel.toString();
    editingControllers[12].text = data.jKfWBel.toString();
    editingControllers[13].text = data.jPaudSJenis.toString();
    editingControllers[14].text = data.jTbmPer.toString();
    editingControllers[15].text = data.jBkbKel.toString();
    editingControllers[16].text = data.jBkbIbu.toString();
    editingControllers[17].text = data.jBkbApe.toString();
    editingControllers[18].text = data.jBkbSim.toString();
    editingControllers[19].text = data.jKtKf.toString();
    editingControllers[20].text = data.jKtPaud.toString();
    editingControllers[21].text = data.jKBkb.toString();
    editingControllers[22].text = data.jKKop.toString();
    editingControllers[23].text = data.jKKet.toString();
    editingControllers[24].text = data.jKLlpt.toString();
    editingControllers[25].text = data.jKLtpk.toString();
    editingControllers[26].text = data.jKLdamas.toString();
    editingControllers[27].text = data.pKopPemKel.toString();
    editingControllers[28].text = data.pKopPemPes.toString();
    editingControllers[29].text = data.pKopMadKel.toString();
    editingControllers[30].text = data.pKopMadPes.toString();
    editingControllers[31].text = data.pKopUtKel.toString();
    editingControllers[32].text = data.pKopMutPes.toString();
    editingControllers[33].text = data.pKopManKel.toString();
    editingControllers[34].text = data.pKopManPes.toString();
    editingControllers[35].text = data.kJKel.toString();
    editingControllers[36].text = data.kJPes.toString();
    editingControllers[37].text = data.ket ?? "";
    editingControllers[38].text = data.status.toString();
  }
}
