// class Kecamatan {
//   final int id;
//   final String nama;
//   final String createdAt;
//   final List<Kelurahan> kelurahan;

//   Kecamatan({
//     required this.id,
//     required this.nama,
//     required this.createdAt,
//     required this.kelurahan,
//   });

//   factory Kecamatan.fromJson(Map<String, dynamic> json) {
//     List<Kelurahan> kelurahan = <Kelurahan>[];
//     if (json['kelurahan'] != null) {
//       json['kelurahan'].forEach((v) {
//         kelurahan.add(Kelurahan.fromJson(v));
//       });
//     }
//     return Kecamatan(
//       id: json['id'],
//       nama: json['nama'],
//       createdAt: json['created_at'],
//       kelurahan: kelurahan,
//     );
//   }
// }

// class Kelurahan {
//   final int id;
//   final int idKec;
//   final String nama;
//   final String createdAt;

//   Kelurahan({
//     required this.id,
//     required this.idKec,
//     required this.nama,
//     required this.createdAt,
//   });

//   factory Kelurahan.fromJson(Map<String, dynamic> json) {
//     return Kelurahan(
//       id: json['id'],
//       idKec: json['id_kec'],
//       nama: json['nama'],
//       createdAt: json['created_at'],
//     );
//   }
// }

class DataTabel {
  final int idKec;
  final String namaKec;
  final String jumlahRw;
  final String jumlahRt;
  final String jumlahKk;
  final int jumlahKecamatan;

  DataTabel({
    required this.idKec,
    required this.namaKec,
    required this.jumlahRw,
    required this.jumlahRt,
    required this.jumlahKk,
    required this.jumlahKecamatan,
  });

  factory DataTabel.fromJson(Map<String, dynamic> json) {
    return DataTabel(
      idKec: json['id_kec'],
      namaKec: json['nama_kec'],
      jumlahRw: json['jumlah_rw'],
      jumlahRt: json['jumlah_rt'],
      jumlahKk: json['jumlah_kk'],
      jumlahKecamatan: json['jumlah_kecamatan'],
    );
  }
}
