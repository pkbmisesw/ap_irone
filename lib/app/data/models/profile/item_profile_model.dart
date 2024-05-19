import 'package:equatable/equatable.dart';

class ItemProfileModel extends Equatable {
  final int? id;
  final String? nama;
  final String? deskripsi;
  final String? email;
  final String? kontak;

  const ItemProfileModel({
    this.id,
    this.nama,
    this.deskripsi,
    this.email,
    this.kontak,
  });

  factory ItemProfileModel.fromJson(Map<String, dynamic> json) =>
      ItemProfileModel(
        id: json['id'] as int?,
        nama: json['nama'] as String?,
        deskripsi: json['deskripsi'] as String?,
        email: json['email'] as String?,
        kontak: json['kontak'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'deskripsi': deskripsi,
        'email': email,
        'kontak': kontak,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, nama, deskripsi, email, kontak];
}
