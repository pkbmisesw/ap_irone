class ModelChartPokja {
  final int jkk_tabung;
  final int j_pkbn;
  final String nama_ling;

  ModelChartPokja(
      {required this.jkk_tabung,
      required this.nama_ling,
      required this.j_pkbn});

  factory ModelChartPokja.fromJson(Map<String, dynamic> json) {
    return ModelChartPokja(
        jkk_tabung: json['status'],
        nama_ling: json['nama_ling'] ?? '',
        j_pkbn: json['id']);
  }
}
