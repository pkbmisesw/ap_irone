class ModelPieRekap {
  final int j_kel;
  final int j_ling;
  final int j_rw;
  final int j_rt;

  ModelPieRekap(
      {required this.j_kel,
      required this.j_ling,
      required this.j_rw,
      required this.j_rt});

  factory ModelPieRekap.fromJson(Map<String, dynamic> json) {
    return ModelPieRekap(
      j_kel: json['j_a_total_l'] ?? 0,
      j_ling: json['j_a_total_p'] ?? 0,
      j_rw: json['j_a_hamil'] ?? 0,
      j_rt: json['j_rt'] ?? 0,
    );
  }
}
