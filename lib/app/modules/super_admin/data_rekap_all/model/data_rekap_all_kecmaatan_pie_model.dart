class TotalDataModel {
  final TotalWargaModel totalWarga;
  final TotalBalitaModel totalBalita;
  final TotalWargaButaModel totalWargaButa;
  final TotalRumahWargaModel totalRumahWarga;
  final TotalKondisiRumahModel totalKondisiRumah;
  final TotalSumberAirModel totalSumberAir;
  final TotalMakananPokokModel totalMakananPokok;
  final TotalPemanfaatanTanahModel totalPemanfaatanTanah;
  final TotalIbuDanBalitaModel totalIbuDanBalita;
  final TotalIndustriModel totalIndustri;

  TotalDataModel({
    required this.totalWarga,
    required this.totalBalita,
    required this.totalWargaButa,
    required this.totalRumahWarga,
    required this.totalKondisiRumah,
    required this.totalSumberAir,
    required this.totalMakananPokok,
    required this.totalPemanfaatanTanah,
    required this.totalIbuDanBalita,
    required this.totalIndustri,
  });

  factory TotalDataModel.fromJson(Map<String, dynamic> json) {
    return TotalDataModel(
      totalWarga: TotalWargaModel.fromJson(json['total_warga']),
      totalBalita: TotalBalitaModel.fromJson(json['total_balita']),
      totalWargaButa: TotalWargaButaModel.fromJson(json['total_warga_buta']),
      totalRumahWarga: TotalRumahWargaModel.fromJson(json['total_rumah_warga']),
      totalKondisiRumah:
          TotalKondisiRumahModel.fromJson(json['total_kondisi_rumah']),
      totalSumberAir: TotalSumberAirModel.fromJson(json['total_sumber_air']),
      totalMakananPokok:
          TotalMakananPokokModel.fromJson(json['total_makanan_pokok']),
      totalPemanfaatanTanah:
          TotalPemanfaatanTanahModel.fromJson(json['total_pemanfaatan_tanah']),
      totalIbuDanBalita:
          TotalIbuDanBalitaModel.fromJson(json['total_ibu_dan_balita']),
      totalIndustri: TotalIndustriModel.fromJson(json['total_industri']),
    );
  }
}

class TotalWargaModel {
  final String totalWargaLaki;
  final String totalWargaPerempuan;

  TotalWargaModel({
    required this.totalWargaLaki,
    required this.totalWargaPerempuan,
  });

  factory TotalWargaModel.fromJson(Map<String, dynamic> json) {
    return TotalWargaModel(
      totalWargaLaki: json['total_warga_laki'],
      totalWargaPerempuan: json['total_warga_perempuan'],
    );
  }
}

class TotalBalitaModel {
  final String totalBalitaLaki;
  final String totalBalitaPerempuan;

  TotalBalitaModel({
    required this.totalBalitaLaki,
    required this.totalBalitaPerempuan,
  });

  factory TotalBalitaModel.fromJson(Map<String, dynamic> json) {
    return TotalBalitaModel(
      totalBalitaLaki: json['total_balita_laki'],
      totalBalitaPerempuan: json['total_balita_perempuan'],
    );
  }
}

class TotalWargaButaModel {
  final String totalButaLaki;
  final String totalButaPerempuan;

  TotalWargaButaModel({
    required this.totalButaLaki,
    required this.totalButaPerempuan,
  });

  factory TotalWargaButaModel.fromJson(Map<String, dynamic> json) {
    return TotalWargaButaModel(
      totalButaLaki: json['total_buta_laki'],
      totalButaPerempuan: json['total_buta_perempuan'],
    );
  }
}

class TotalRumahWargaModel {
  final String totalRumahSehat;
  final String totalRumahTidakSehat;

  TotalRumahWargaModel({
    required this.totalRumahSehat,
    required this.totalRumahTidakSehat,
  });

  factory TotalRumahWargaModel.fromJson(Map<String, dynamic> json) {
    return TotalRumahWargaModel(
      totalRumahSehat: json['total_rumah_sehat'],
      totalRumahTidakSehat: json['total_rumah_tidak_sehat'],
    );
  }
}

class TotalKondisiRumahModel {
  final String totalTempatSampah;
  final String totalSpal;
  final String totalJambanKeluarga;
  final String totalStikerP4k;

  TotalKondisiRumahModel({
    required this.totalTempatSampah,
    required this.totalSpal,
    required this.totalJambanKeluarga,
    required this.totalStikerP4k,
  });

  factory TotalKondisiRumahModel.fromJson(Map<String, dynamic> json) {
    return TotalKondisiRumahModel(
      totalTempatSampah: json['total_tempat_sampah'],
      totalSpal: json['total_spal'],
      totalJambanKeluarga: json['total_jamban_keluarga'],
      totalStikerP4k: json['total_stiker_p4k'],
    );
  }
}

class TotalSumberAirModel {
  final String totalPdam;
  final String totalSumur;
  final String totalSungai;
  final String totalDll;

  TotalSumberAirModel({
    required this.totalPdam,
    required this.totalSumur,
    required this.totalSungai,
    required this.totalDll,
  });

  factory TotalSumberAirModel.fromJson(Map<String, dynamic> json) {
    return TotalSumberAirModel(
      totalPdam: json['total_pdam'],
      totalSumur: json['total_sumur'],
      totalSungai: json['total_sungai'],
      totalDll: json['total_dll'],
    );
  }
}

class TotalMakananPokokModel {
  final String totalBeras;
  final String totalNonBeras;

  TotalMakananPokokModel({
    required this.totalBeras,
    required this.totalNonBeras,
  });

  factory TotalMakananPokokModel.fromJson(Map<String, dynamic> json) {
    return TotalMakananPokokModel(
      totalBeras: json['total_beras'],
      totalNonBeras: json['total_non_beras'],
    );
  }
}

class TotalPemanfaatanTanahModel {
  final String totalTernak;
  final String totalIkan;
  final String totalWarungHidup;
  final String totalLumbungHidup;
  final String totalToga;
  final String totalTanamanKeras;

  TotalPemanfaatanTanahModel({
    required this.totalTernak,
    required this.totalIkan,
    required this.totalWarungHidup,
    required this.totalLumbungHidup,
    required this.totalTanamanKeras,
    required this.totalToga,
  });

  factory TotalPemanfaatanTanahModel.fromJson(Map<String, dynamic> json) {
    return TotalPemanfaatanTanahModel(
      totalTernak: json['total_ternak'],
      totalIkan: json['total_ikan'],
      totalWarungHidup: json['total_warung_hidup'],
      totalToga: json['total_toga'],
      totalTanamanKeras: json['total_tanaman_keras'],
      totalLumbungHidup: json['total_lumbung_hidup'],
    );
  }
}

class TotalIbuDanBalitaModel {
  final String toalibuhamil;
  final String totalibumenyusui;
  final String totalbalita;

  TotalIbuDanBalitaModel({
    required this.toalibuhamil,
    required this.totalibumenyusui,
    required this.totalbalita,
  });

  factory TotalIbuDanBalitaModel.fromJson(Map<String, dynamic> json) {
    return TotalIbuDanBalitaModel(
        toalibuhamil: json['total_ibu_hamil'],
        totalibumenyusui: json['total_ibu_menyusui'],
        totalbalita: json['total_balita']);
  }
}

class TotalIndustriModel {
  final String totalpangan;
  final String totalsandang;
  final String totaljasa;

  TotalIndustriModel({
    required this.totalpangan,
    required this.totalsandang,
    required this.totaljasa,
  });

  factory TotalIndustriModel.fromJson(Map<String, dynamic> json) {
    return TotalIndustriModel(
        totalpangan: json['total_pangan'],
        totalsandang: json['total_sandang'],
        totaljasa: json['total_jasa']);
  }
}
