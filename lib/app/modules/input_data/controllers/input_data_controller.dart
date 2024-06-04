import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:silahan_kawan/app/data/models/input_data.dart';
import 'package:silahan_kawan/app/services/input_data_services.dart';
import 'package:silahan_kawan/app/shared/shared_method.dart';
import 'package:silahan_kawan/app/utils/local_db.dart';

class InputDataController extends GetxController {
  final InputDataServices _inputDataServices = InputDataServices();
  late InputDataModel inputDataModel;

  final datas = [
    "ID Kelurahan",
    "Nama Lingkungan",
    "ID Kecamatan",
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

  @override
  onInit() {
    editingControllers.assignAll(
        List.generate(datas.length, (index) => TextEditingController()));
    editingControllers.first.text = LocalDb.credential.users?.idKel != null
        ? LocalDb.credential.users!.idKel.toString()
        : "";
    editingControllers[2].text = LocalDb.credential.users?.idKec != null
        ? LocalDb.credential.users!.idKec.toString()
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

  Future<void> submitData() async {
    if (formKey.currentState!.validate()) {
      loadingBtn.value = true;

      final idKel = int.parse(editingControllers[0].text);
      final namaLing = editingControllers[1].text;
      final idKec = int.parse(editingControllers[2].text) ?? 0;
      final jRw = int.tryParse(editingControllers[3].text) ?? 0;
      final jRt = int.tryParse(editingControllers[4].text) ?? 0;
      final jDasawisma = int.tryParse(editingControllers[5].text) ?? 0;
      final jKrt = int.tryParse(editingControllers[6].text) ?? 0;
      final jKk = int.tryParse(editingControllers[7].text) ?? 0;
      final jATotalL = int.tryParse(editingControllers[8].text) ?? 0;
      final jATotalP = int.tryParse(editingControllers[9].text) ?? 0;
      final jABalitaL = int.tryParse(editingControllers[10].text) ?? 0;
      final jABalitaP = int.tryParse(editingControllers[11].text) ?? 0;
      final jAPus = int.tryParse(editingControllers[12].text) ?? 0;
      final jAWus = int.tryParse(editingControllers[13].text) ?? 0;
      final jAHamil = int.tryParse(editingControllers[14].text) ?? 0;
      final jASusui = int.tryParse(editingControllers[15].text) ?? 0;
      final jALansia = int.tryParse(editingControllers[16].text) ?? 0;
      final jABlaki = int.tryParse(editingControllers[17].text) ?? 0;
      final jABcwe = int.tryParse(editingControllers[18].text) ?? 0;
      final jABb = int.tryParse(editingControllers[19].text) ?? 0;
      final krSehat = int.tryParse(editingControllers[20].text) ?? 0;
      final krTdkSehat = int.tryParse(editingControllers[21].text) ?? 0;
      final jrTsampah = int.tryParse(editingControllers[22].text) ?? 0;
      final jrSpal = int.tryParse(editingControllers[23].text) ?? 0;
      final jrJamban = int.tryParse(editingControllers[24].text) ?? 0;
      final jrStiker = int.tryParse(editingControllers[25].text) ?? 0;
      final sakPdam = int.tryParse(editingControllers[26].text) ?? 0;
      final sakSumur = int.tryParse(editingControllers[27].text) ?? 0;
      final sakSungai = int.tryParse(editingControllers[28].text) ?? 0;
      final sakDll = int.tryParse(editingControllers[29].text) ?? 0;
      final mpBeras = int.tryParse(editingControllers[30].text) ?? 0;
      final mpNonberas = int.tryParse(editingControllers[31].text) ?? 0;
      final jkkTabung = int.tryParse(editingControllers[32].text) ?? 0;
      final kUpk = int.tryParse(editingControllers[33].text) ?? 0;
      final kpTernak = int.tryParse(editingControllers[34].text) ?? 0;
      final kpIkan = int.tryParse(editingControllers[35].text) ?? 0;
      final kpWarung = int.tryParse(editingControllers[36].text) ?? 0;
      final kpLumbung = int.tryParse(editingControllers[37].text) ?? 0;
      final kpToga = int.tryParse(editingControllers[38].text) ?? 0;
      final kpTanaman = int.tryParse(editingControllers[39].text) ?? 0;
      final iPangan = int.tryParse(editingControllers[40].text) ?? 0;
      final iSandang = int.tryParse(editingControllers[41].text) ?? 0;
      final iJasa = int.tryParse(editingControllers[42].text) ?? 0;
      final kesLing = int.tryParse(editingControllers[43].text) ?? 0;
      final ket = editingControllers[44].text;

      inputDataModel = InputDataModel(
        idKel: idKel,
        namaLing: namaLing,
        idKec: idKec,
        jRw: jRw,
        jRt: jRt,
        jDasawisma: jDasawisma,
        jKrt: jKrt,
        jKk: jKk,
        jATotalL: jATotalL,
        jATotalP: jATotalP,
        jABalitaL: jABalitaL,
        jABalitaP: jABalitaP,
        jAPus: jAPus,
        jAWus: jAWus,
        jAHamil: jAHamil,
        jASusui: jASusui,
        jALansia: jALansia,
        jABlaki: jABlaki,
        jABcwe: jABcwe,
        jABb: jABb,
        krSehat: krSehat,
        krTdkSehat: krTdkSehat,
        jrTsampah: jrTsampah,
        jrSpal: jrSpal,
        jrJamban: jrJamban,
        jrStiker: jrStiker,
        sakPdam: sakPdam,
        sakSumur: sakSumur,
        sakSungai: sakSungai,
        sakDll: sakDll,
        mpBeras: mpBeras,
        mpNonberas: mpNonberas,
        jkkTabung: jkkTabung,
        kUpk: kUpk,
        kpTernak: kpTernak,
        kpIkan: kpIkan,
        kpWarung: kpWarung,
        kpLumbung: kpLumbung,
        kpToga: kpToga,
        kpTanaman: kpTanaman,
        iPangan: iPangan,
        iSandang: iSandang,
        iJasa: iJasa,
        kesLing: kesLing,
        ket: ket,
      );
    }

    try {
      final res = await _inputDataServices.submitData(inputDataModel);
      loadingBtn.value = false;

      showSnackbar(message: res);
    } on DioException catch (e) {
      loadingBtn.value = false;
      showSnackbar(message: e.response?.data['message']);
      return Future.error(e);
    }
  }
}
