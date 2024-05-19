class ModelPiePokjaa {
  final int j_pkdrt;
  final int p_pkbn_anggota;
  final int pola_kel;
  final int pola_anggota;

  ModelPiePokjaa(
      {required this.j_pkdrt,
      required this.p_pkbn_anggota,
      required this.pola_kel,
      required this.pola_anggota});

  factory ModelPiePokjaa.fromJson(Map<String, dynamic> json) {
    return ModelPiePokjaa(
      j_pkdrt: json['j_pkdrt'] ?? 0,
      p_pkbn_anggota: json['p_pkbn_anggota'] ?? 0,
      pola_kel: json['pola_kel'] ?? 0,
      pola_anggota: json['pola_anggota'] ?? 0,
    );
  }
}
