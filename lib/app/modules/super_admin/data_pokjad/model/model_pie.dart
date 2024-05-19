class ModelPiePokjad {
  final int j_pkdrt;
  final int p_pkbn_anggota;
  final int pola_kel;
  final int pola_anggota;

  ModelPiePokjad(
      {required this.j_pkdrt,
      required this.p_pkbn_anggota,
      required this.pola_kel,
      required this.pola_anggota});

  factory ModelPiePokjad.fromJson(Map<String, dynamic> json) {
    return ModelPiePokjad(
      j_pkdrt: json['j_k_pos'] ?? 0,
      p_pkbn_anggota: json['j_k_gizi'] ?? 0,
      pola_kel: json['pola_kel'] ?? 0,
      pola_anggota: json['pola_anggota'] ?? 0,
    );
  }
}
