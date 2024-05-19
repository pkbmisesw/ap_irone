class ModelChartPokjab {
  final int jkk_tabung;
  final String nama_ling;

  ModelChartPokjab({required this.jkk_tabung, required this.nama_ling});

  factory ModelChartPokjab.fromJson(Map<String, dynamic> json) {
    return ModelChartPokjab(
        jkk_tabung: json['status'], nama_ling: json['nama_ling'] ?? '');
  }
}
