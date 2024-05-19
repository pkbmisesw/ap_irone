class ModelPiePokjab {
  final int j_pkdrt;
  final int p_pkbn_anggota;
  final int pola_kel;
  final int pola_anggota;

  ModelPiePokjab(
      {required this.j_pkdrt,
      required this.p_pkbn_anggota,
      required this.pola_kel,
      required this.pola_anggota});

  factory ModelPiePokjab.fromJson(Map<String, dynamic> json) {
    return ModelPiePokjab(
      j_pkdrt: json['j_wm_l'] ?? 0,
      p_pkbn_anggota: json['j_wm_p'] ?? 0,
      pola_kel: json['pola_kel'] ?? 0,
      pola_anggota: json['pola_anggota'] ?? 0,
    );
  }
}
