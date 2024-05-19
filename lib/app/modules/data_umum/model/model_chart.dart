class ModelChartApiUmum {
  final int jkk_tabung;
  final String nama_ling;

  ModelChartApiUmum({required this.jkk_tabung, required this.nama_ling});

  factory ModelChartApiUmum.fromJson(Map<String, dynamic> json) {
    return ModelChartApiUmum(
        jkk_tabung: json['status'], nama_ling: json['nama_ling'] ?? '');
  }
}
