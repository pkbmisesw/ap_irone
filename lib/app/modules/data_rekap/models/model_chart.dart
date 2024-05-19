class ModelChartApi {
  final int jkk_tabung;
  final String nama_ling;

  ModelChartApi({required this.jkk_tabung, required this.nama_ling});

  factory ModelChartApi.fromJson(Map<String, dynamic> json) {
    return ModelChartApi(
        jkk_tabung: json['j_dasawisma'], nama_ling: json['nama_ling'] ?? '');
  }
}
