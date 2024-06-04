import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silahan_kawan/app/modules/data_rekap/models/data_rekap_models.dart';
import 'package:silahan_kawan/app/modules/data_umum/model/data_umum_models.dart';
import 'package:silahan_kawan/app/utils/local_db.dart';

class SuperAdminDataRekapServices extends GetxController {
  late DataUmumModel dataUmumModel;
  RxInt stepperValue = 0.obs;
  RxBool isLoading = false.obs;

  final datas = [
    "Nama Kecamatan",
    "Nama Kelurahan",
    "Nama Lingkungan",
    "Jumlah RW",
    "Jumlah RT",
    "Jumlah Dasa wisma",
    "Jumlah Kepala Rumah Tangga",
    "Jumlah KK",
    "Jumlah Anggota Keluarga Total Laki-laki",
    "Jumlah Anggota Keluarga Total Perempuan",
    "Jumlah Balita Keluarga Total Laki-laki",
    "Jumlah Balita Keluarga Total Perempuan",
    "Jumlah Anggota Keluarga PUS",
    "Jumlah Anggota Keluarga WUS",
    "Jumlah Anggota Keluarga Ibu Hamil",
    "Jumlah Anggota Keluarga Ibu menyusui",
    "Jumlah Anggota Keluarga Lansia",
    "Jumlah Anggota Keluarga 3 Buta Laki-laki",
    "Jumlah Anggota Keluarga 3 Buta Perempuan",
    "Jumlah Anggota Keluarga Berkebutuhan khusus",
    "Kriteria Rumah Sehat",
    "Kriteria Rumah Tidak Sehat",
    "Jumlah Rumah memiliki Tj_rw Pembuangan Sampah",
    "Jumlah Rumah memiliki SPAL",
    "Jumlah Rumah memiliki Jamban Keluarga",
    "Jumlah Rumah memiliki Stiker P4K",
    "Sumber Air Keluarga Pdam",
    "Sumber Air Keluarga Sumur",
    "Sumber Air Keluarga Sungai",
    "Sumber Air Keluarga DLL",
    "Makanan Pokok Beras",
    "Makanan Pokok Non Beras",
    "Jumlah KK Yang memiliki tabung",
    "Keluarga Mengikuti Kegiatan UP2K",
    "Keluarga Mengikuti Kegiatan Pemanfaatan Peternakan",
    "Keluarga Mengikuti Kegiatan Pemanfaatan Perikanan",
    "Keluarga Mengikuti Kegiatan Pemanfaatan Warung Hidup",
    "Keluarga Mengikuti Kegiatan Pemanfaatan Lumbung Hidup",
    "Keluarga Mengikuti Kegiatan Pemanfaatan Toga",
    "Keluarga Mengikuti Kegiatan Tanaman Keras",
    "Keluarga Mengikuti Kegiatan Industri Pangan",
    "Keluarga Mengikuti Kegiatan Industri Sandang",
    "Keluarga Mengikuti Kegiatan Industri Jasa",
    "Keluarga Mengikuti Kegiatan Kesehatan Lingkungan",
    "Keterangan",
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
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.number);
    keyboardTypes.add(TextInputType.text);

    super.onInit();
  }

  void updateEditingControllers(DataRekapModels data) {
    editingControllers[0].text = data.kecamatan_nama.toString();
    editingControllers[1].text = data.kelurahan_nama.toString();
    editingControllers[2].text = data.namaLing.toString();
    editingControllers[3].text = data.jRw.toString();
    editingControllers[4].text = data.jRt.toString();
    editingControllers[5].text = data.jDasawisma.toString();
    editingControllers[6].text = data.jKrt.toString();
    editingControllers[7].text = data.jKk.toString();
    editingControllers[8].text = data.jATotalL.toString();
    editingControllers[9].text = data.jATotalP.toString();
    editingControllers[10].text = data.jABalitaL.toString();
    editingControllers[11].text = data.jABalitaP.toString();
    editingControllers[12].text = data.jAPus.toString();
    editingControllers[13].text = data.jAWus.toString();
    editingControllers[14].text = data.jAHamil.toString();
    editingControllers[15].text = data.jASusui.toString();
    editingControllers[16].text = data.jALansia.toString();
    editingControllers[17].text = data.jABlaki.toString();
    editingControllers[18].text = data.jABcwe.toString();
    editingControllers[19].text = data.jABb.toString();
    editingControllers[20].text = data.krSehat.toString();
    editingControllers[21].text = data.krTdkSehat.toString();
    editingControllers[22].text = data.jrTsampah.toString();
    editingControllers[23].text = data.jrSpal.toString();
    editingControllers[24].text = data.jrJamban.toString();
    editingControllers[25].text = data.jrStiker.toString();
    editingControllers[26].text = data.sakPdam.toString();
    editingControllers[27].text = data.sakSumur.toString();
    editingControllers[28].text = data.sakSungai.toString();
    editingControllers[29].text = data.sakDll.toString();
    editingControllers[30].text = data.mpBeras.toString();
    editingControllers[31].text = data.mpNonberas.toString();
    editingControllers[32].text = data.jkkTabung.toString();
    editingControllers[33].text = data.jkkTabung.toString();
    editingControllers[34].text = data.kpTernak.toString();
    editingControllers[35].text = data.kpIkan.toString();
    editingControllers[36].text = data.kpWarung.toString();
    editingControllers[37].text = data.kpLumbung.toString();
    editingControllers[38].text = data.kpToga.toString();
    editingControllers[39].text = data.kpTanaman.toString();
    editingControllers[40].text = data.iPangan.toString();
    editingControllers[41].text = data.iSandang.toString();
    editingControllers[42].text = data.iJasa.toString();
    editingControllers[43].text = data.kesLing.toString();
    editingControllers[44].text = data.ket ?? '';
  }
}
