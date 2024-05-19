class ModelChartPokjad {
  final int jkk_tabung;
  final String nama_ling;

  ModelChartPokjad({required this.jkk_tabung, required this.nama_ling});

  factory ModelChartPokjad.fromJson(Map<String, dynamic> json) {
    return ModelChartPokjad(
        jkk_tabung: json['status'], nama_ling: json['nama_ling'] ?? '');
  }
}
