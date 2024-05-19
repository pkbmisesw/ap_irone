import 'package:equatable/equatable.dart';

class ItemPengurusModel extends Equatable {
  final int? id;
  final String? nama;
  final String? jabatan;
  final String? gambar;

  const ItemPengurusModel({this.id, this.nama, this.jabatan, this.gambar});

  factory ItemPengurusModel.fromJson(Map<String, dynamic> json) =>
      ItemPengurusModel(
        id: json['id'] as int?,
        nama: json['nama'] as String?,
        jabatan: json['jabatan'] as String?,
        gambar: json['gambar'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'jabatan': jabatan,
        'gambar': gambar,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, nama, jabatan, gambar];
}
