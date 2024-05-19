import 'package:equatable/equatable.dart';

class DataUmumModel extends Equatable {
  final int id;
  final int idKec;
  final int idKel;
  final int noUrut;
  final String namaLing;
  final int pRw;
  final int pRt;
  final int dasa;
  final int kRumah;
  final int kk;
  final int jLaki;
  final int jPerempuan;
  final int aLaki;
  final int aPerempuan;
  final int uLaki;
  final int uPerempuan;
  final int kLaki;
  final int kPerempuan;
  final int hLaki;
  final int hPerempuan;
  final int bLaki;
  final int bPerempuan;
  final String? ket;
  final int status;

  final String? kecamatan_nama;
  final String? kelurahan_nama;

  const DataUmumModel({
    this.id = 0,
    this.idKec = 0,
    this.idKel = 0,
    this.noUrut = 0,
    this.namaLing = '',
    this.pRw = 0,
    this.pRt = 0,
    this.dasa = 0,
    this.kRumah = 0,
    this.kk = 0,
    this.jLaki = 0,
    this.jPerempuan = 0,
    this.aLaki = 0,
    this.aPerempuan = 0,
    this.uLaki = 0,
    this.uPerempuan = 0,
    this.kLaki = 0,
    this.kPerempuan = 0,
    this.hLaki = 0,
    this.hPerempuan = 0,
    this.bLaki = 0,
    this.bPerempuan = 0,
    this.ket,
    this.status = 0,
    this.kecamatan_nama,
    this.kelurahan_nama,
  });

  factory DataUmumModel.fromJson(Map<String, dynamic> json) {
    return DataUmumModel(
      id: json['id'] ?? 0,
      idKec: json['id_kec'] ?? 0,
      idKel: json['id_kel'] ?? 0,
      noUrut: json['no_urut'] ?? 0,
      namaLing: json['nama_ling'] ?? '',
      pRw: json['p_rw'] ?? 0,
      pRt: json['p_rt'] ?? 0,
      dasa: json['dasa'] ?? 0,
      kRumah: json['k_rumah'] ?? 0,
      kk: json['kk'] ?? 0,
      jLaki: json['j_laki'] ?? 0,
      jPerempuan: json['j_perempuan'] ?? 0,
      aLaki: json['a_laki'] ?? 0,
      aPerempuan: json['a_perempuan'] ?? 0,
      uLaki: json['u_laki'] ?? 0,
      uPerempuan: json['u_perempuan'] ?? 0,
      kLaki: json['k_laki'] ?? 0,
      kPerempuan: json['k_perempuan'] ?? 0,
      hLaki: json['h_laki'] ?? 0,
      hPerempuan: json['h_perempuan'] ?? 0,
      bLaki: json['b_laki'] ?? 0,
      bPerempuan: json['b_perempuan'] ?? 0,
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
      noUrut,
      namaLing,
      pRw,
      pRt,
      dasa,
      kRumah,
      kk,
      jLaki,
      jPerempuan,
      aLaki,
      aPerempuan,
      uLaki,
      uPerempuan,
      kLaki,
      kPerempuan,
      hLaki,
      hPerempuan,
      bLaki,
      bPerempuan,
      ket,
      status,
    ];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_kec': idKec,
      'id_kel': idKel,
      'no_urut': noUrut,
      'nama_ling': namaLing,
      'p_rw': pRw,
      'p_rt': pRt,
      'dasa': dasa,
      'k_rumah': kRumah,
      'kk': kk,
      'j_laki': jLaki,
      'j_perempuan': jPerempuan,
      'a_laki': aLaki,
      'a_perempuan': aPerempuan,
      'u_laki': uLaki,
      'u_perempuan': uPerempuan,
      'k_laki': kLaki,
      'k_perempuan': kPerempuan,
      'h_laki': hLaki,
      'h_perempuan': hPerempuan,
      'b_laki': bLaki,
      'b_perempuan': bPerempuan,
      'ket': ket,
      'status': status,
    };
  }
}
