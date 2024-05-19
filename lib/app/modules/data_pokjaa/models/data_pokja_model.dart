import 'package:equatable/equatable.dart';

class DataPokjaModel extends Equatable {
  final int id;
  final int idKec;
  final int idKel;
  final String namaLing;
  final int jPkbn;
  final int jPkdrt;
  final int pola;
  final int pPkbnSim;
  final int pPkbnAnggota;
  final int pPkdrtSim;
  final int pPkdrtAnggota;
  final int polaKel;
  final int polaAnggota;
  final int lansiaKel;
  final int lansiaAnggota;
  final int gJumKer;
  final int gJumRuk;
  final int gJumAgama;
  final int gJumJimpit;
  final int gJumArisan;
  final String? ket;
  final int status;

  final String? kecamatan_nama;
  final String? kelurahan_nama;

  const DataPokjaModel({
    this.id = 0,
    required this.idKec,
    required this.idKel,
    required this.namaLing,
    required this.jPkbn,
    required this.jPkdrt,
    required this.pola,
    required this.pPkbnSim,
    required this.pPkbnAnggota,
    required this.pPkdrtSim,
    required this.pPkdrtAnggota,
    required this.polaKel,
    required this.polaAnggota,
    required this.lansiaKel,
    required this.lansiaAnggota,
    required this.gJumKer,
    required this.gJumRuk,
    required this.gJumAgama,
    required this.gJumJimpit,
    required this.gJumArisan,
    this.ket,
    required this.status,
    this.kecamatan_nama,
    this.kelurahan_nama,
  });

  factory DataPokjaModel.fromJson(Map<String, dynamic> json) {
    return DataPokjaModel(
      id: json['id'] ?? 0,
      idKec: json['id_kec'] ?? 0,
      idKel: json['id_kel'] ?? 0,
      namaLing: json['nama_ling'] ?? '',
      jPkbn: json['j_pkbn'] ?? 0,
      jPkdrt: json['j_pkdrt'] ?? 0,
      pola: json['pola'] ?? 0,
      pPkbnSim: json['p_pkbn_sim'] ?? 0,
      pPkbnAnggota: json['p_pkbn_anggota'] ?? 0,
      pPkdrtSim: json['p_pkdrt_sim'] ?? 0,
      pPkdrtAnggota: json['p_pkdrt_anggota'] ?? 0,
      polaKel: json['pola_kel'] ?? 0,
      polaAnggota: json['pola_anggota'] ?? 0,
      lansiaKel: json['lansia_kel'] ?? 0,
      lansiaAnggota: json['lansia_anggota'] ?? 0,
      gJumKer: json['g_jum_ker'] ?? 0,
      gJumRuk: json['g_jum_ruk'] ?? 0,
      gJumAgama: json['g_jum_agama'] ?? 0,
      gJumJimpit: json['g_jum_jimpit'] ?? 0,
      gJumArisan: json['g_jum_arisan'] ?? 0,
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
      jPkbn,
      jPkdrt,
      pola,
      pPkbnSim,
      pPkbnAnggota,
      pPkdrtSim,
      pPkdrtAnggota,
      polaKel,
      polaAnggota,
      lansiaKel,
      lansiaAnggota,
      gJumKer,
      gJumRuk,
      gJumAgama,
      gJumJimpit,
      gJumArisan,
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
      'j_pkbn': jPkbn,
      'j_pkdrt': jPkdrt,
      'pola': pola,
      'p_pkbn_sim': pPkbnSim,
      'p_pkbn_anggota': pPkbnAnggota,
      'p_pkdrt_sim': pPkdrtSim,
      'p_pkdrt_anggota': pPkdrtAnggota,
      'pola_kel': polaKel,
      'pola_anggota': polaAnggota,
      'lansia_kel': lansiaKel,
      'lansia_anggota': lansiaAnggota,
      'g_jum_ker': gJumKer,
      'g_jum_ruk': gJumRuk,
      'g_jum_agama': gJumAgama,
      'g_jum_jimpit': gJumJimpit,
      'g_jum_arisan': gJumArisan,
      'ket': ket,
      'status': status,
    };
  }
}
