import 'package:equatable/equatable.dart';

// *MODELS BARU UNTUK MEMPERJELAS NAMA CLASS*

class DataRekapModels extends Equatable {
  final int id;
  final int idKec;
  final int idKel;
  final String namaLing;
  final int jKel;
  final int jLing;
  final int jRw;
  final int jRt;
  final int jDasawisma;
  final int jKrt;
  final int jKk;
  final int jATotalL;
  final int jATotalP;
  final int jABalitaL;
  final int jABalitaP;
  final int jAPus;
  final int jAWus;
  final int jAHamil;
  final int jASusui;
  final int jALansia;
  final int jABlaki;
  final int jABcwe;
  final int jABb;
  final int krSehat;
  final int krTdkSehat;
  final int jrTsampah;
  final int jrSpal;
  final int jrJamban;
  final int jrStiker;
  final int sakPdam;
  final int sakSumur;
  final int sakSungai;
  final int sakDll;
  final int mpBeras;
  final int mpNonberas;
  final int jkkTabung;
  final int kUpk;
  final int kpTernak;
  final int kpIkan;
  final int kpWarung;
  final int kpLumbung;
  final int kpToga;
  final int kpTanaman;
  final int iPangan;
  final int iSandang;
  final int iJasa;
  final int kesLing;
  final String? ket;
  final int status;
  final String? kecamatan_nama;
  final String? kelurahan_nama;

  const DataRekapModels({
    this.id = 0,
    this.idKec = 0,
    this.idKel = 0,
    this.namaLing = '',
    this.jKel = 0,
    this.jLing = 0,
    this.jRw = 0,
    this.jRt = 0,
    this.jDasawisma = 0,
    this.jKrt = 0,
    this.jKk = 0,
    this.jATotalL = 0,
    this.jATotalP = 0,
    this.jABalitaL = 0,
    this.jABalitaP = 0,
    this.jAPus = 0,
    this.jAWus = 0,
    this.jAHamil = 0,
    this.jASusui = 0,
    this.jALansia = 0,
    this.jABlaki = 0,
    this.jABcwe = 0,
    this.jABb = 0,
    this.krSehat = 0,
    this.krTdkSehat = 0,
    this.jrTsampah = 0,
    this.jrSpal = 0,
    this.jrJamban = 0,
    this.jrStiker = 0,
    this.sakPdam = 0,
    this.sakSumur = 0,
    this.sakSungai = 0,
    this.sakDll = 0,
    this.mpBeras = 0,
    this.mpNonberas = 0,
    this.jkkTabung = 0,
    this.kUpk = 0,
    this.kpTernak = 0,
    this.kpIkan = 0,
    this.kpWarung = 0,
    this.kpLumbung = 0,
    this.kpToga = 0,
    this.kpTanaman = 0,
    this.iPangan = 0,
    this.iSandang = 0,
    this.iJasa = 0,
    this.kesLing = 0,
    this.ket,
    this.status = 0,
    this.kecamatan_nama,
    this.kelurahan_nama,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_kec': idKec,
      'id_kel': idKel,
      'nama_ling': namaLing,
      'j_kel': jKel,
      'j_ling': jLing,
      'j_rw': jRw,
      'j_rt': jRt,
      'j_dasawisma': jDasawisma,
      'j_krt': jKrt,
      'j_kk': jKk,
      'j_a_total_l': jATotalL,
      'j_a_total_p': jATotalP,
      'j_a_balita_l': jABalitaL,
      'j_a_balita_p': jABalitaP,
      'j_a_pus': jAPus,
      'j_a_wus': jAWus,
      'j_a_hamil': jAHamil,
      'j_a_susui': jASusui,
      'j_a_lansia': jALansia,
      'j_a_blaki': jABlaki,
      'j_a_bcwe': jABcwe,
      'j_a_bb': jABb,
      'kr_sehat': krSehat,
      'kr_tdk_sehat': krTdkSehat,
      'jr_tsampah': jrTsampah,
      'jr_spal': jrSpal,
      'jr_jamban': jrJamban,
      'jr_stiker': jrStiker,
      'sak_pdam': sakPdam,
      'sak_sumur': sakSumur,
      'sak_sungai': sakSungai,
      'sak_dll': sakDll,
      'mp_beras': mpBeras,
      'mp_nonberas': mpNonberas,
      'jkk_tabung': jkkTabung,
      'k_upk': kUpk,
      'kp_ternak': kpTernak,
      'kp_ikan': kpIkan,
      'kp_warung': kpWarung,
      'kp_lumbung': kpLumbung,
      'kp_toga': kpToga,
      'kp_tanaman': kpTanaman,
      'i_pangan': iPangan,
      'i_sandang': iSandang,
      'i_jasa': iJasa,
      'kes_ling': kesLing,
      'ket': ket,
      'status': status,
    };
  }

  factory DataRekapModels.fromJson(Map<String, dynamic> json) {
    return DataRekapModels(
      id: json['id'] ?? 0,
      idKec: json['id_kec'] ?? 0,
      idKel: json['id_kel'] ?? 0,
      namaLing: json['nama_ling'] ?? '',
      jKel: json['j_kel'] ?? 0,
      jLing: json['j_ling'] ?? 0,
      jRw: json['j_rw'] ?? 0,
      jRt: json['j_rt'] ?? 0,
      jDasawisma: json['j_dasawisma'] ?? 0,
      jKrt: json['j_krt'] ?? 0,
      jKk: json['j_kk'] ?? 0,
      jATotalL: json['j_a_total_l'] ?? 0,
      jATotalP: json['j_a_total_p'] ?? 0,
      jABalitaL: json['j_a_balita_l'] ?? 0,
      jABalitaP: json['j_a_balita_p'] ?? 0,
      jAPus: json['j_a_pus'] ?? 0,
      jAWus: json['j_a_wus'] ?? 0,
      jAHamil: json['j_a_hamil'] ?? 0,
      jASusui: json['j_a_susui'] ?? 0,
      jALansia: json['j_a_lansia'] ?? 0,
      jABlaki: json['j_a_blaki'] ?? 0,
      jABcwe: json['j_a_bcwe'] ?? 0,
      jABb: json['j_a_bb'] ?? 0,
      krSehat: json['kr_sehat'] ?? 0,
      krTdkSehat: json['kr_tdk_sehat'] ?? 0,
      jrTsampah: json['jr_tsampah'] ?? 0,
      jrSpal: json['jr_spal'] ?? 0,
      jrJamban: json['jr_jamban'] ?? 0,
      jrStiker: json['jr_stiker'] ?? 0,
      sakPdam: json['sak_pdam'] ?? 0,
      sakSumur: json['sak_sumur'] ?? 0,
      sakSungai: json['sak_sungai'] ?? 0,
      sakDll: json['sak_dll'] ?? 0,
      mpBeras: json['mp_beras'] ?? 0,
      mpNonberas: json['mp_nonberas'] ?? 0,
      jkkTabung: json['jkk_tabung'] ?? 0,
      kUpk: json['k_upk'] ?? 0,
      kpTernak: json['kp_ternak'] ?? 0,
      kpIkan: json['kp_ikan'] ?? 0,
      kpWarung: json['kp_warung'] ?? 0,
      kpLumbung: json['kp_lumbung'] ?? 0,
      kpToga: json['kp_toga'] ?? 0,
      kpTanaman: json['kp_tanaman'] ?? 0,
      iPangan: json['i_pangan'] ?? 0,
      iSandang: json['i_sandang'] ?? 0,
      iJasa: json['i_jasa'] ?? 0,
      kesLing: json['kes_ling'] ?? 0,
      ket: json['ket'] ?? '',
      status: json['status'] ?? 0,
      kecamatan_nama: json['kecamatan_nama'] ?? null,
      kelurahan_nama: json['kelurahan_nama'] ?? null,
    );
  }

  DataRekapModels copyWith({
    int? id,
    int? idKec,
    int? idKel,
    String? namaLing,
    int? jKel,
    int? jLing,
    int? jRw,
    int? jRt,
    int? jDasawisma,
    int? jKrt,
    int? jKk,
    int? jATotalL,
    int? jATotalP,
    int? jABalitaL,
    int? jABalitaP,
    int? jAPus,
    int? jAWus,
    int? jAHamil,
    int? jASusui,
    int? jALansia,
    int? jABlaki,
    int? jABcwe,
    int? jABb,
    int? krSehat,
    int? krTdkSehat,
    int? jrTsampah,
    int? jrSpal,
    int? jrJamban,
    int? jrStiker,
    int? sakPdam,
    int? sakSumur,
    int? sakSungai,
    int? sakDll,
    int? mpBeras,
    int? mpNonberas,
    int? jkkTabung,
    int? kUpk,
    int? kpTernak,
    int? kpIkan,
    int? kpWarung,
    int? kpLumbung,
    int? kpToga,
    int? kpTanaman,
    int? iPangan,
    int? iSandang,
    int? iJasa,
    int? kesLing,
    String? ket,
    int? status,
  }) {
    return DataRekapModels(
      id: id ?? this.id,
      idKec: idKec ?? this.idKec,
      idKel: idKel ?? this.idKel,
      namaLing: namaLing ?? this.namaLing,
      jKel: jKel ?? this.jKel,
      jLing: jLing ?? this.jLing,
      jRw: jRw ?? this.jRw,
      jRt: jRt ?? this.jRt,
      jDasawisma: jDasawisma ?? this.jDasawisma,
      jKrt: jKrt ?? this.jKrt,
      jKk: jKk ?? this.jKk,
      jATotalL: jATotalL ?? this.jATotalL,
      jATotalP: jATotalP ?? this.jATotalP,
      jABalitaL: jABalitaL ?? this.jABalitaL,
      jABalitaP: jABalitaP ?? this.jABalitaP,
      jAPus: jAPus ?? this.jAPus,
      jAWus: jAWus ?? this.jAWus,
      jAHamil: jAHamil ?? this.jAHamil,
      jASusui: jASusui ?? this.jASusui,
      jALansia: jALansia ?? this.jALansia,
      jABlaki: jABlaki ?? this.jABlaki,
      jABcwe: jABcwe ?? this.jABcwe,
      jABb: jABb ?? this.jABb,
      krSehat: krSehat ?? this.krSehat,
      krTdkSehat: krTdkSehat ?? this.krTdkSehat,
      jrTsampah: jrTsampah ?? this.jrTsampah,
      jrSpal: jrSpal ?? this.jrSpal,
      jrJamban: jrJamban ?? this.jrJamban,
      jrStiker: jrStiker ?? this.jrStiker,
      sakPdam: sakPdam ?? this.sakPdam,
      sakSumur: sakSumur ?? this.sakSumur,
      sakSungai: sakSungai ?? this.sakSungai,
      sakDll: sakDll ?? this.sakDll,
      mpBeras: mpBeras ?? this.mpBeras,
      mpNonberas: mpNonberas ?? this.mpNonberas,
      jkkTabung: jkkTabung ?? this.jkkTabung,
      kUpk: kUpk ?? this.kUpk,
      kpTernak: kpTernak ?? this.kpTernak,
      kpIkan: kpIkan ?? this.kpIkan,
      kpWarung: kpWarung ?? this.kpWarung,
      kpLumbung: kpLumbung ?? this.kpLumbung,
      kpToga: kpToga ?? this.kpToga,
      kpTanaman: kpTanaman ?? this.kpTanaman,
      iPangan: iPangan ?? this.iPangan,
      iSandang: iSandang ?? this.iSandang,
      iJasa: iJasa ?? this.iJasa,
      kesLing: kesLing ?? this.kesLing,
      ket: ket ?? this.ket,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      idKec,
      idKel,
      namaLing,
      jKel,
      jLing,
      jRw,
      jRt,
      jDasawisma,
      jKrt,
      jKk,
      jATotalL,
      jATotalP,
      jABalitaL,
      jABalitaP,
      jAPus,
      jAWus,
      jAHamil,
      jASusui,
      jALansia,
      jABlaki,
      jABcwe,
      jABb,
      krSehat,
      krTdkSehat,
      jrTsampah,
      jrSpal,
      jrJamban,
      jrStiker,
      sakPdam,
      sakSumur,
      sakSungai,
      sakDll,
      mpBeras,
      mpNonberas,
      jkkTabung,
      kUpk,
      kpTernak,
      kpIkan,
      kpWarung,
      kpLumbung,
      kpToga,
      kpTanaman,
      iPangan,
      iSandang,
      iJasa,
      kesLing,
      ket,
      status,
    ];
  }
}
