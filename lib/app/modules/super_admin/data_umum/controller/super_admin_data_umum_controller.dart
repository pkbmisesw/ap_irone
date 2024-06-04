import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silahan_kawan/app/modules/data_umum/model/data_umum_models.dart';
import 'package:silahan_kawan/app/utils/local_db.dart';

class SuperAdminDataUmumServices extends GetxController {
  late DataUmumModel dataUmumModel;
  RxInt stepperValue = 0.obs;
  RxBool isLoading = false.obs;

  final datas = [
    "Nama Kecamatan",
    "Nama Kelurahan",
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
    "Kader Khusus Laki",
    "JUMLAH TENAGA SEKRETARIAT Honorer Laki",
    "JUMLAH TENAGA SEKRETARIAT Honorer Perempuan",
    "JUMLAH TENAGA SEKRETARIAT Bantuan Laki",
    "JUMLAH TENAGA SEKRETARIAT Bantuan Perempuan",
    "Keterangan",
    "Status",
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

  void updateEditingControllers(DataUmumModel data) {
    editingControllers[0].text = data.kecamatan_nama.toString();
    editingControllers[1].text = data.kelurahan_nama.toString();
    editingControllers[2].text = data.noUrut.toString();
    editingControllers[3].text = data.namaLing;
    editingControllers[4].text = data.pRw.toString();
    editingControllers[5].text = data.pRt.toString();
    editingControllers[6].text = data.dasa.toString();
    editingControllers[7].text = data.kRumah.toString();
    editingControllers[8].text = data.kk.toString();
    editingControllers[9].text = data.jLaki.toString();
    editingControllers[10].text = data.jPerempuan.toString();
    editingControllers[11].text = data.aLaki.toString();
    editingControllers[12].text = data.aPerempuan.toString();
    editingControllers[13].text = data.uLaki.toString();
    editingControllers[14].text = data.uPerempuan.toString();
    editingControllers[15].text = data.kLaki.toString();
    editingControllers[16].text = data.kPerempuan.toString();
    editingControllers[17].text = data.hLaki.toString();
    editingControllers[18].text = data.hPerempuan.toString();
    editingControllers[19].text = data.bLaki.toString();
    editingControllers[20].text = data.bPerempuan.toString();
    editingControllers[21].text = data.ket.toString() ?? '';
    editingControllers[22].text = data.status.toString();
  }
}
