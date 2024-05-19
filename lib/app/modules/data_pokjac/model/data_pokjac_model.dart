import 'package:equatable/equatable.dart';

class DataPokjacModel extends Equatable {
  final int id;
  final int idKec;
  final int idKel;
  final String namaLing;
  final int jKPangan;
  final int jKSandang;
  final int jKTaRt;
  final int pMpBeras;
  final int pMpNberas;
  final int pPPTernak;
  final int pPPIkan;
  final int pPPWarung;
  final int pPPLumbung;
  final int pPPToga;
  final int pPPTkeras;
  final int jiPangan;
  final int jiSandang;
  final int jiJasa;
  final int jrSehat;
  final int jrTsehat;
  final String? ket;
  final int status;

  final String? kecamatan_nama;
  final String? kelurahan_nama;

  const DataPokjacModel({
    this.id = 0,
    required this.idKec,
    required this.idKel,
    required this.namaLing,
    required this.jKPangan,
    required this.jKSandang,
    required this.jKTaRt,
    required this.pMpBeras,
    required this.pMpNberas,
    required this.pPPTernak,
    required this.pPPIkan,
    required this.pPPWarung,
    required this.pPPLumbung,
    required this.pPPToga,
    required this.pPPTkeras,
    required this.jiPangan,
    required this.jiSandang,
    required this.jiJasa,
    required this.jrSehat,
    required this.jrTsehat,
    this.ket,
    required this.status,
    this.kecamatan_nama,
    this.kelurahan_nama,
  });

  factory DataPokjacModel.fromJson(Map<String, dynamic> json) {
    return DataPokjacModel(
      id: json['id'] ?? 0,
      idKec: json['id_kec'] ?? 0,
      idKel: json['id_kel'] ?? 0,
      namaLing: json['nama_ling'] ?? '',
      jKPangan: json['j_k_pangan'] ?? 0,
      jKSandang: json['j_k_sandang'] ?? 0,
      jKTaRt: json['j_k_ta_rt'] ?? 0,
      pMpBeras: json['p_mp_beras'] ?? 0,
      pMpNberas: json['p_mp_nberas'] ?? 0,
      pPPTernak: json['p_pp_ternak'] ?? 0,
      pPPIkan: json['p_pp_ikan'] ?? 0,
      pPPWarung: json['p_pp_warung'] ?? 0,
      pPPLumbung: json['p_pp_lumbung'] ?? 0,
      pPPToga: json['p_pp_toga'] ?? 0,
      pPPTkeras: json['p_pp_tkeras'] ?? 0,
      jiPangan: json['ji_pangan'] ?? 0,
      jiSandang: json['ji_sandang'] ?? 0,
      jiJasa: json['ji_jasa'] ?? 0,
      jrSehat: json['jr_sehat'] ?? 0,
      jrTsehat: json['jr_tsehat'] ?? 0,
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
      jKPangan,
      jKSandang,
      jKTaRt,
      pMpBeras,
      pMpNberas,
      pPPTernak,
      pPPIkan,
      pPPWarung,
      pPPLumbung,
      pPPToga,
      pPPTkeras,
      jiPangan,
      jiSandang,
      jiJasa,
      jrSehat,
      jrTsehat,
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
      'j_k_pangan': jKPangan,
      'j_k_sandang': jKSandang,
      'j_k_ta_rt': jKTaRt,
      'p_mp_beras': pMpBeras,
      'p_mp_nberas': pMpNberas,
      'p_pp_ternak': pPPTernak,
      'p_pp_ikan': pPPIkan,
      'p_pp_warung': pPPWarung,
      'p_pp_lumbung': pPPLumbung,
      'p_pp_toga': pPPToga,
      'p_pp_tkeras': pPPTkeras,
      'ji_pangan': jiPangan,
      'ji_sandang': jiSandang,
      'ji_jasa': jiJasa,
      'jr_sehat': jrSehat,
      'jr_tsehat': jrTsehat,
      'ket': ket,
      'status': status,
    };
  }
}
