import 'package:equatable/equatable.dart';

class ItemArticleModel extends Equatable {
  final int? id;
  final String? nama;
  final String? gambar;
  final String? penulis;
  final String? tgl;
  final String? sdes;
  final String? des;
  final int? stat;
  final int? view;
  final String? seo;
  final String? kelas;
  final int? noUrut;
  final String? createdAt;
  final String? updatedAt;

  const ItemArticleModel({
    this.id,
    this.nama,
    this.gambar,
    this.penulis,
    this.tgl,
    this.sdes,
    this.des,
    this.stat,
    this.view,
    this.seo,
    this.kelas,
    this.noUrut,
    this.createdAt,
    this.updatedAt,
  });

  factory ItemArticleModel.fromJson(Map<String, dynamic> json) =>
      ItemArticleModel(
        id: json['id'] as int?,
        nama: json['nama'] as String?,
        gambar: json['gambar'] as String? ?? '',
        penulis: json['penulis'] as String?,
        tgl: json['tgl'] as String?,
        sdes: json['sdes'] as String?,
        des: json['des'] as String?,
        stat: json['stat'] as int?,
        view: json['view'] as int?,
        seo: json['seo'] as String?,
        kelas: json['kelas'] as String?,
        noUrut: json['no_urut'] as int?,
        createdAt: json['created_at'] as String?,
        updatedAt: json['updated_at'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nama': nama,
        'gambar': gambar,
        'penulis': penulis,
        'tgl': tgl,
        'sdes': sdes,
        'des': des,
        'stat': stat,
        'view': view,
        'seo': seo,
        'kelas': kelas,
        'no_urut': noUrut,
        'created_at': createdAt,
        'updated_at': updatedAt,
      };

  ItemArticleModel copyWith({
    int? id,
    String? nama,
    String? gambar,
    String? penulis,
    String? tgl,
    String? sdes,
    String? des,
    int? stat,
    int? view,
    String? seo,
    String? kelas,
    int? noUrut,
    String? createdAt,
    String? updatedAt,
  }) {
    return ItemArticleModel(
      id: id ?? this.id,
      nama: nama ?? this.nama,
      gambar: gambar ?? this.gambar,
      penulis: penulis ?? this.penulis,
      tgl: tgl ?? this.tgl,
      sdes: sdes ?? this.sdes,
      des: des ?? this.des,
      stat: stat ?? this.stat,
      view: view ?? this.view,
      seo: seo ?? this.seo,
      kelas: kelas ?? this.kelas,
      noUrut: noUrut ?? this.noUrut,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      id,
      nama,
      gambar,
      penulis,
      tgl,
      sdes,
      des,
      stat,
      view,
      seo,
      kelas,
      noUrut,
      createdAt,
      updatedAt,
    ];
  }
}
