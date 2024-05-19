class ModelChartPokjac {
  final int jkk_tabung;
  final String nama_ling;

  ModelChartPokjac({required this.jkk_tabung, required this.nama_ling});

  factory ModelChartPokjac.fromJson(Map<String, dynamic> json) {
    return ModelChartPokjac(
        jkk_tabung: json['status'], nama_ling: json['nama_ling'] ?? '');
  }
}
