class DataTableModel {
  final bool success;
  final List<DataTotal> dataTotal;
  final List<DataRekapAllDataTabel> DataRekapAlldataTabel;
  final String message;

  DataTableModel({
    required this.success,
    required this.dataTotal,
    required this.DataRekapAlldataTabel,
    required this.message,
  });

  factory DataTableModel.fromJson(Map<String, dynamic> json) {
    List<DataTotal> dataTotalList = [];
    for (var data in json['data']['data_total']) {
      dataTotalList.add(DataTotal.fromJson(data));
    }

    List<DataRekapAllDataTabel> DataRekapAlldataTabelList = [];
    for (var data in json['data']['data_tabel']) {
      DataRekapAlldataTabelList.add(DataRekapAllDataTabel.fromJson(data));
    }

    return DataTableModel(
      success: json['success'],
      dataTotal: dataTotalList,
      DataRekapAlldataTabel: DataRekapAlldataTabelList,
      message: json['message'],
    );
  }
}

class DataTotal {
  final String totalWargaLaki;
  final String totalWargaPerempuan;
  final String totalBalitaLaki;
  final String totalBalitaPerempuan;
  final String totalButaLaki;
  final String totalButaPerempuan;
  final String totalRumahSehat;
  final String totalRumahTidakSehat;
  final String totalTempatSampah;
  final String totalSpal;
  final String totalJambanKeluarga;
  final String totalStikerP4k;
  final String totalPdam;
  final String totalSumur;
  final String totalSungai;
  final String totalDll;
  final String totalBeras;
  final String totalNonBeras;
  final String totalTernak;
  final String totalIkan;
  final String totalWarungHidup;
  final String totalLumbungHidup;
  final String totalToga;
  final String totalTanamanKeras;
  final String totalIbuHamil;
  final String totalIbuMenyusui;
  final String totalBalita;
  final String totalPangan;
  final String totalSandang;
  final String totalJasa;

  DataTotal({
    required this.totalWargaLaki,
    required this.totalWargaPerempuan,
    required this.totalBalitaLaki,
    required this.totalBalitaPerempuan,
    required this.totalButaLaki,
    required this.totalButaPerempuan,
    required this.totalRumahSehat,
    required this.totalRumahTidakSehat,
    required this.totalTempatSampah,
    required this.totalSpal,
    required this.totalJambanKeluarga,
    required this.totalStikerP4k,
    required this.totalPdam,
    required this.totalSumur,
    required this.totalSungai,
    required this.totalDll,
    required this.totalBeras,
    required this.totalNonBeras,
    required this.totalTernak,
    required this.totalIkan,
    required this.totalWarungHidup,
    required this.totalLumbungHidup,
    required this.totalToga,
    required this.totalTanamanKeras,
    required this.totalIbuHamil,
    required this.totalIbuMenyusui,
    required this.totalBalita,
    required this.totalPangan,
    required this.totalSandang,
    required this.totalJasa,
  });

  factory DataTotal.fromJson(Map<String, dynamic> json) {
    return DataTotal(
      totalWargaLaki: json['total_warga_laki'],
      totalWargaPerempuan: json['total_warga_perempuan'],
      totalBalitaLaki: json['total_balita_laki'],
      totalBalitaPerempuan: json['total_balita_perempuan'],
      totalButaLaki: json['total_buta_laki'],
      totalButaPerempuan: json['total_buta_perempuan'],
      totalRumahSehat: json['total_rumah_sehat'],
      totalRumahTidakSehat: json['total_rumah_tidak_sehat'],
      totalTempatSampah: json['total_tempat_sampah'],
      totalSpal: json['total_spal'],
      totalJambanKeluarga: json['total_jamban_keluarga'],
      totalStikerP4k: json['total_stiker_p4k'],
      totalPdam: json['total_pdam'],
      totalSumur: json['total_sumur'],
      totalSungai: json['total_sungai'],
      totalDll: json['total_dll'],
      totalBeras: json['total_beras'],
      totalNonBeras: json['total_non_beras'],
      totalTernak: json['total_ternak'],
      totalIkan: json['total_ikan'],
      totalWarungHidup: json['total_warung_hidup'],
      totalLumbungHidup: json['total_lumbung_hidup'],
      totalToga: json['total_toga'],
      totalTanamanKeras: json['total_tanaman_keras'],
      totalIbuHamil: json['total_ibu_hamil'],
      totalIbuMenyusui: json['total_ibu_menyusui'],
      totalBalita: json['total_balita'],
      totalPangan: json['total_pangan'],
      totalSandang: json['total_sandang'],
      totalJasa: json['total_jasa'],
    );
  }
}

class DataRekapAllDataTabel {
  final int idKel;
  final String namaKel;
  final String jumlahRw;
  final String jumlahRt;
  final String jumlahKk;

  DataRekapAllDataTabel({
    required this.idKel,
    required this.namaKel,
    required this.jumlahRw,
    required this.jumlahRt,
    required this.jumlahKk,
  });

  factory DataRekapAllDataTabel.fromJson(Map<String, dynamic> json) {
    return DataRekapAllDataTabel(
      idKel: json['id_kel'],
      namaKel: json['nama_kel'],
      jumlahRw: json['jumlah_rw'],
      jumlahRt: json['jumlah_rt'],
      jumlahKk: json['jumlah_kk'],
    );
  }
}
