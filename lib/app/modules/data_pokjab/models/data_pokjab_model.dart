import 'package:equatable/equatable.dart';

class DataPokjabModel extends Equatable {
  final int id;
  final int idKec;
  final int idKel;
  final String namaLing;
  final int jWmL;
  final int jWmP;
  final int jABel;
  final int jAWBel;
  final int jBBel;
  final int jBWBel;
  final int jCBel;
  final int jCWBel;
  final int jKfBel;
  final int jKfWBel;
  final int jPaudSJenis;
  final int jTbmPer;
  final int jBkbKel;
  final int jBkbIbu;
  final int jBkbApe;
  final int jBkbSim;
  final int jKtKf;
  final int jKtPaud;
  final int jKBkb;
  final int jKKop;
  final int jKKet;
  final int jKLlpt;
  final int jKLtpk;
  final int jKLdamas;
  final int pKopPemKel;
  final int pKopPemPes;
  final int pKopMadKel;
  final int pKopMadPes;
  final int pKopUtKel;
  final int pKopMutPes;
  final int pKopManKel;
  final int pKopManPes;
  final int kJKel;
  final int kJPes;
  final String? ket;
  final int status;
  final String? kecamatan_nama;
  final String? kelurahan_nama;

  const DataPokjabModel({
    this.id = 0,
    this.idKec = 0,
    this.idKel = 0,
    this.namaLing = '',
    this.jWmL = 0,
    this.jWmP = 0,
    this.jABel = 0,
    this.jAWBel = 0,
    this.jBBel = 0,
    this.jBWBel = 0,
    this.jCBel = 0,
    this.jCWBel = 0,
    this.jKfBel = 0,
    this.jKfWBel = 0,
    this.jPaudSJenis = 0,
    this.jTbmPer = 0,
    this.jBkbKel = 0,
    this.jBkbIbu = 0,
    this.jBkbApe = 0,
    this.jBkbSim = 0,
    this.jKtKf = 0,
    this.jKtPaud = 0,
    this.jKBkb = 0,
    this.jKKop = 0,
    this.jKKet = 0,
    this.jKLlpt = 0,
    this.jKLtpk = 0,
    this.jKLdamas = 0,
    this.pKopPemKel = 0,
    this.pKopPemPes = 0,
    this.pKopMadKel = 0,
    this.pKopMadPes = 0,
    this.pKopUtKel = 0,
    this.pKopMutPes = 0,
    this.pKopManKel = 0,
    this.pKopManPes = 0,
    this.kJKel = 0,
    this.kJPes = 0,
    this.ket,
    this.status = 0,
    this.kecamatan_nama,
    this.kelurahan_nama,
  });

  factory DataPokjabModel.fromJson(Map<String, dynamic> json) {
    return DataPokjabModel(
      id: json['id'] ?? 0,
      idKec: json['id_kec'] ?? 0,
      idKel: json['id_kel'] ?? 0,
      namaLing: json['nama_ling'] ?? '',
      jWmL: json['j_wm_l'] ?? 0,
      jWmP: json['j_wm_p'] ?? 0,
      jABel: json['j_a_bel'] ?? 0,
      jAWBel: json['j_a_wbel'] ?? 0,
      jBBel: json['j_b_bel'] ?? 0,
      jBWBel: json['j_b_wbel'] ?? 0,
      jCBel: json['j_c_bel'] ?? 0,
      jCWBel: json['j_c_wbel'] ?? 0,
      jKfBel: json['j_kf_bel'] ?? 0,
      jKfWBel: json['j_kf_wbel'] ?? 0,
      jPaudSJenis: json['j_paud_sjenis'] ?? 0,
      jTbmPer: json['j_tbm_per'] ?? 0,
      jBkbKel: json['j_bkb_kel'] ?? 0,
      jBkbIbu: json['j_bkb_ibu'] ?? 0,
      jBkbApe: json['j_bkb_ape'] ?? 0,
      jBkbSim: json['j_bkb_sim'] ?? 0,
      jKtKf: json['j_kt_kf'] ?? 0,
      jKtPaud: json['j_kt_paud'] ?? 0,
      jKBkb: json['j_k_bkb'] ?? 0,
      jKKop: json['j_k_kop'] ?? 0,
      jKKet: json['j_k_ket'] ?? 0,
      jKLlpt: json['j_kl_lpt'] ?? 0,
      jKLtpk: json['j_kl_tpk'] ?? 0,
      jKLdamas: json['j_kl_damas'] ?? 0,
      pKopPemKel: json['p_kop_pem_kel'] ?? 0,
      pKopPemPes: json['p_kop_pem_pes'] ?? 0,
      pKopMadKel: json['p_kop_mad_kel'] ?? 0,
      pKopMadPes: json['p_kop_mad_pes'] ?? 0,
      pKopUtKel: json['p_kop_ut_kel'] ?? 0,
      pKopMutPes: json['p_kop_mut_pes'] ?? 0,
      pKopManKel: json['p_kop_man_kel'] ?? 0,
      pKopManPes: json['p_kop_man_pes'] ?? 0,
      kJKel: json['k_j_kel'] ?? 0,
      kJPes: json['k_j_pes'] ?? 0,
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
      jWmL,
      jWmP,
      jABel,
      jAWBel,
      jBBel,
      jBWBel,
      jCBel,
      jCWBel,
      jKfBel,
      jKfWBel,
      jPaudSJenis,
      jTbmPer,
      jBkbKel,
      jBkbIbu,
      jBkbApe,
      jBkbSim,
      jKtKf,
      jKtPaud,
      jKBkb,
      jKKop,
      jKKet,
      jKLlpt,
      jKLtpk,
      jKLdamas,
      pKopPemKel,
      pKopPemPes,
      pKopMadKel,
      pKopMadPes,
      pKopUtKel,
      pKopMutPes,
      pKopManKel,
      pKopManPes,
      kJKel,
      kJPes,
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
      'j_wm_l': jWmL,
      'j_wm_p': jWmP,
      'j_a_bel': jABel,
      'j_a_wbel': jAWBel,
      'j_b_bel': jBBel,
      'j_b_wbel': jBWBel,
      'j_c_bel': jCBel,
      'j_c_wbel': jCWBel,
      'j_kf_bel': jKfBel,
      'j_kf_wbel': jKfWBel,
      'j_paud_sjenis': jPaudSJenis,
      'j_tbm_per': jTbmPer,
      'j_bkb_kel': jBkbKel,
      'j_bkb_ibu': jBkbIbu,
      'j_bkb_ape': jBkbApe,
      'j_bkb_sim': jBkbSim,
      'j_kt_kf': jKtKf,
      'j_kt_paud': jKtPaud,
      'j_k_bkb': jKBkb,
      'j_k_kop': jKKop,
      'j_k_ket': jKKet,
      'j_kl_lpt': jKLlpt,
      'j_kl_tpk': jKLtpk,
      'j_kl_damas': jKLdamas,
      'p_kop_pem_kel': pKopPemKel,
      'p_kop_pem_pes': pKopPemPes,
      'p_kop_mad_kel': pKopMadKel,
      'p_kop_mad_pes': pKopMadPes,
      'p_kop_ut_kel': pKopUtKel,
      'p_kop_mut_pes': pKopMutPes,
      'p_kop_man_kel': pKopManKel,
      'p_kop_man_pes': pKopManPes,
      'k_j_kel': kJKel,
      'k_j_pes': kJPes,
      'ket': ket,
      'status': status,
    };
  }
}
