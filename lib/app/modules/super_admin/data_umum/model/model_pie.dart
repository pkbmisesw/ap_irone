class ModelPieUmum {
  final int j_laki;
  final int j_perempuan;
  final int dasa;
  final int kk;
  final int a_laki;
  final int a_perempuan;

  ModelPieUmum(
      {required this.j_laki,
      required this.j_perempuan,
      required this.dasa,
      required this.kk,
      required this.a_laki,
      required this.a_perempuan});

  factory ModelPieUmum.fromJson(Map<String, dynamic> json) {
    return ModelPieUmum(
      j_laki: json['j_laki'] ?? 0,
      j_perempuan: json['j_perempuan'] ?? 0,
      dasa: json['dasa'] ?? 0,
      kk: json['kk'] ?? 0,
      a_laki: json['a_laki'] ?? 0,
      a_perempuan: json['a_perempuan'] ?? 0,
    );
  }
}
