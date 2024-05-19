import 'package:equatable/equatable.dart';

class DataPokjadModel extends Equatable {
  final int id;
  final int idKec;
  final int idKel;
  final String namaLing;
  final int jKPos;
  final int jKGizi;
  final int jKKes;
  final int jKNar;
  final int jKPhbs;
  final int jKKB;
  final int kpJumlah;
  final int kpJumlahI;
  final int kpLanJK;
  final int kpLanJA;
  final int kpLanBG;
  final int jJamban;
  final int jSPAL;
  final int jSampah;
  final int jMCK;
  final int jKPdam;
  final int jKSumur;
  final int jKSungai;
  final int jKLain;
  final int jPus;
  final int jWus;
  final int jaL;
  final int jaP;
  final int jKK;
  final String? ket;
  final int status;

  final String? kecamatan_nama;
  final String? kelurahan_nama;

  const DataPokjadModel({
    this.id = 0,
    this.idKec = 0,
    this.idKel = 0,
    this.namaLing = '',
    this.jKPos = 0,
    this.jKGizi = 0,
    this.jKKes = 0,
    this.jKNar = 0,
    this.jKPhbs = 0,
    this.jKKB = 0,
    this.kpJumlah = 0,
    this.kpJumlahI = 0,
    this.kpLanJK = 0,
    this.kpLanJA = 0,
    this.kpLanBG = 0,
    this.jJamban = 0,
    this.jSPAL = 0,
    this.jSampah = 0,
    this.jMCK = 0,
    this.jKPdam = 0,
    this.jKSumur = 0,
    this.jKSungai = 0,
    this.jKLain = 0,
    this.jPus = 0,
    this.jWus = 0,
    this.jaL = 0,
    this.jaP = 0,
    this.jKK = 0,
    this.ket,
    this.status = 0,
    this.kecamatan_nama,
    this.kelurahan_nama,
  });

  factory DataPokjadModel.fromJson(Map<String, dynamic> json) {
    return DataPokjadModel(
      id: json['id'] ?? 0,
      idKec: json['id_kec'] ?? 0,
      idKel: json['id_kel'] ?? 0,
      namaLing: json['nama_ling'] ?? '',
      jKPos: json['j_k_pos'] ?? 0,
      jKGizi: json['j_k_gizi'] ?? 0,
      jKKes: json['j_k_kes'] ?? 0,
      jKNar: json['j_k_nar'] ?? 0,
      jKPhbs: json['j_k_phbs'] ?? 0,
      jKKB: json['j_k_kb'] ?? 0,
      kpJumlah: json['kp_jumlah'] ?? 0,
      kpJumlahI: json['kp_jumlah_i'] ?? 0,
      kpLanJK: json['kp_lan_jk'] ?? 0,
      kpLanJA: json['kp_lan_ja'] ?? 0,
      kpLanBG: json['kp_lan_bg'] ?? 0,
      jJamban: json['j_jamban'] ?? 0,
      jSPAL: json['j_spal'] ?? 0,
      jSampah: json['j_sampah'] ?? 0,
      jMCK: json['j_mck'] ?? 0,
      jKPdam: json['j_k_pdam'] ?? 0,
      jKSumur: json['j_k_sumur'] ?? 0,
      jKSungai: json['j_k_sungai'] ?? 0,
      jKLain: json['j_k_lain'] ?? 0,
      jPus: json['j_pus'] ?? 0,
      jWus: json['j_wus'] ?? 0,
      jaL: json['ja_l'] ?? 0,
      jaP: json['ja_p'] ?? 0,
      jKK: json['j_kk'] ?? 0,
      ket: json['ket'] ?? '',
      status: json['status'] ?? 0,
      kecamatan_nama: json['kecamatan_nama'] ?? null,
      kelurahan_nama: json['kelurahan_nama'] ?? null,
    );
  }

  @override
  List<Object?> get props {
    return [
      id,
      idKec,
      idKel,
      namaLing,
      jKPos,
      jKGizi,
      jKKes,
      jKNar,
      jKPhbs,
      jKKB,
      kpJumlah,
      kpJumlahI,
      kpLanJK,
      kpLanJA,
      kpLanBG,
      jJamban,
      jSPAL,
      jSampah,
      jMCK,
      jKPdam,
      jKSumur,
      jKSungai,
      jKLain,
      jPus,
      jWus,
      jaL,
      jaP,
      jKK,
      ket,
      status,
    ];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_kec': idKec,
      'id_kel': idKel,
      'nama_ling': namaLing,
      'j_k_pos': jKPos,
      'j_k_gizi': jKGizi,
      'j_k_kes': jKKes,
      'j_k_nar': jKNar,
      'j_k_phbs': jKPhbs,
      'j_k_kb': jKKB,
      'kp_jumlah': kpJumlah,
      'kp_jumlah_i': kpJumlahI,
      'kp_lan_jk': kpLanJK,
      'kp_lan_ja': kpLanJA,
      'kp_lan_bg': kpLanBG,
      'j_jamban': jJamban,
      'j_spal': jSPAL,
      'j_sampah': jSampah,
      'j_mck': jMCK,
      'j_k_pdam': jKPdam,
      'j_k_sumur': jKSumur,
      'j_k_sungai': jKSungai,
      'j_k_lain': jKLain,
      'j_pus': jPus,
      'j_wus': jWus,
      'ja_l': jaL,
      'ja_p': jaP,
      'j_kk': jKK,
      'ket': ket,
      'status': status,
    };
  }
}
