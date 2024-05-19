import 'package:equatable/equatable.dart';

class ItemLetterModel extends Equatable {
  final int? id;
  final String? nama;
  final String? tgl;
  final String? url;
  final int? stat;
  final String? createdAt;
  final String? updatedAt;

  const ItemLetterModel({
    this.id,
    this.nama,
    this.tgl,
    this.url,
    this.stat,
    this.createdAt,
    this.updatedAt,
  });

  factory ItemLetterModel.fromJson(Map<String, dynamic> json) =>
      ItemLetterModel(
        id: json['id'] as int?,
        nama: json['nama'] as String?,
        tgl: json['tgl'] as String?,
        url: json['url'] as String?,
        stat: json['stat'] as int?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'tgl': tgl,
        'url': url,
        'stat': stat,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, nama, tgl, url, stat, createdAt, updatedAt];
}
