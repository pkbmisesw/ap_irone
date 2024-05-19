import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:irone/app/modules/data_pokjad/model/data_pokjad_model.dart';
import 'package:irone/app/utils/local_db.dart';

class AdminKecDataPokjadController extends GetxController {
  late DataPokjadModel dataPokjaMDataPokjadModel;
  RxInt stepperValue = 0.obs;
  RxBool isLoading = false.obs;

  final datas = [
    'ID Kecamatan',
    'ID Kelurahan',
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

  void updateEditingControllers(DataPokjadModel data) {
    editingControllers[0].text = data.idKec.toString();
    editingControllers[1].text = data.idKel.toString();
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

  // Future<void> submitData() async {
  //   loadingBtn.value = true;

  //   final idKel = int.parse(editingControllers[0].text);
  //   final namaLing = editingControllers[1].text;
  //   final idKec = int.tryParse(editingControllers[2].text) ?? 0;
  //   final jRw = int.tryParse(editingControllers[3].text) ?? 0;
  //   final jRt = int.tryParse(editingControllers[4].text) ?? 0;
  //   final jDasawisma = int.tryParse(editingControllers[5].text) ?? 0;
  //   final jKrt = int.tryParse(editingControllers[6].text) ?? 0;
  //   final jKk = int.tryParse(editingControllers[7].text) ?? 0;
  //   final jATotalL = int.tryParse(editingControllers[8].text) ?? 0;
  //   final jATotalP = int.tryParse(editingControllers[9].text) ?? 0;
  //   final jABalitaL = int.tryParse(editingControllers[10].text) ?? 0;
  //   final jABalitaP = int.tryParse(editingControllers[11].text) ?? 0;
  //   final jAPus = int.tryParse(editingControllers[12].text) ?? 0;
  //   final jAWus = int.tryParse(editingControllers[13].text) ?? 0;
  //   final jAHamil = int.tryParse(editingControllers[14].text) ?? 0;
  //   final jASusui = int.tryParse(editingControllers[15].text) ?? 0;
  //   final jALansia = int.tryParse(editingControllers[16].text) ?? 0;
  //   final jABlaki = int.tryParse(editingControllers[17].text) ?? 0;
  //   final jABcwe = int.tryParse(editingControllers[18].text) ?? 0;
  //   final jABb = int.tryParse(editingControllers[19].text) ?? 0;
  //   final krSehat = int.tryParse(editingControllers[20].text) ?? 0;
  //   final krTdkSehat = int.tryParse(editingControllers[21].text) ?? 0;
  //   final jrTsampah = int.tryParse(editingControllers[22].text) ?? 0;
  //   final jrSpal = int.tryParse(editingControllers[23].text) ?? 0;
  //   final jrJamban = int.tryParse(editingControllers[24].text) ?? 0;
  //   final jrStiker = int.tryParse(editingControllers[25].text) ?? 0;
  //   final sakPdam = int.tryParse(editingControllers[26].text) ?? 0;
  //   final sakSumur = int.tryParse(editingControllers[27].text) ?? 0;
  //   final sakSungai = int.tryParse(editingControllers[28].text) ?? 0;
  //   final sakDll = int.tryParse(editingControllers[29].text) ?? 0;
  //   final mpBeras = int.tryParse(editingControllers[30].text) ?? 0;
  //   final mpNonberas = int.tryParse(editingControllers[31].text) ?? 0;
  //   final jkkTabung = int.tryParse(editingControllers[32].text) ?? 0;
  //   final kUpk = int.tryParse(editingControllers[33].text) ?? 0;
  //   final kpTernak = int.tryParse(editingControllers[34].text) ?? 0;
  //   final kpIkan = int.tryParse(editingControllers[35].text) ?? 0;
  //   final kpWarung = int.tryParse(editingControllers[36].text) ?? 0;
  //   final kpLumbung = int.tryParse(editingControllers[37].text) ?? 0;
  //   final kpToga = int.tryParse(editingControllers[38].text) ?? 0;
  //   final kpTanaman = int.tryParse(editingControllers[39].text) ?? 0;
  //   final iPangan = int.tryParse(editingControllers[40].text) ?? 0;
  //   final iSandang = int.tryParse(editingControllers[41].text) ?? 0;
  //   final iJasa = int.tryParse(editingControllers[42].text) ?? 0;
  //   final kesLing = int.tryParse(editingControllers[43].text) ?? 0;
  //   final ket = editingControllers[44].text;

  //   dataPokjaMDataPokjacModel = DataPokjacModel(
  //     idKel: idKel,
  //     namaLing: namaLing,
  //     idKec: idKec,
  //     jRw: jRw,
  //     jRt: jRt,
  //     jDasawisma: jDasawisma,
  //     jKrt: jKrt,
  //     jKk: jKk,
  //     jATotalL: jATotalL,
  //     jATotalP: jATotalP,
  //     jABalitaL: jABalitaL,
  //     jABalitaP: jABalitaP,
  //     jAPus: jAPus,
  //     jAWus: jAWus,
  //     jAHamil: jAHamil,
  //     jASusui: jASusui,
  //     jALansia: jALansia,
  //     jABlaki: jABlaki,
  //     jABcwe: jABcwe,
  //     jABb: jABb,
  //     krSehat: krSehat,
  //     krTdkSehat: krTdkSehat,
  //     jrTsampah: jrTsampah,
  //     jrSpal: jrSpal,
  //     jrJamban: jrJamban,
  //     jrStiker: jrStiker,
  //     sakPdam: sakPdam,
  //     sakSumur: sakSumur,
  //     sakSungai: sakSungai,
  //     sakDll: sakDll,
  //     mpBeras: mpBeras,
  //     mpNonberas: mpNonberas,
  //     jkkTabung: jkkTabung,
  //     kUpk: kUpk,
  //     kpTernak: kpTernak,
  //     kpIkan: kpIkan,
  //     kpWarung: kpWarung,
  //     kpLumbung: kpLumbung,
  //     kpToga: kpToga,
  //     kpTanaman: kpTanaman,
  //     iPangan: iPangan,
  //     iSandang: iSandang,
  //     iJasa: iJasa,
  //     kesLing: kesLing,
  //     ket: ket,
  //   );

  //   try {
  //     final res = await updateData(dataPokjaMDataPokjacModel);
  //     loadingBtn.value = false;

  //     showSnackbar(message: res);
  //   } on DioException catch (e) {
  //     loadingBtn.value = false;
  //     showSnackbar(message: e.response?.data['message']);
  //     return Future.error(e);
  //   }
  // }

  // // Update Data
  // Future<String> updateData(DataPokjacModel data) {
  //   final dio = BaseDio().dio;
  //   dio.options.baseUrl = ConstantsEndpoints.main;
  //   return dio
  //       .put('edit-barang-rekap', data: data.toJson())
  //       .then((value) => value.data["message"]);
  // }

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
      stepperButtonText.value = 'Update';
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
}
