class UsersModel {
  final int id;
  final String nama;
  final String email;
  final dynamic images;
  final int level;
  final int idKel;
  final int idKec;
  final int status;
  final String apiToken;

  UsersModel({
    required this.id,
    required this.nama,
    required this.email,
    required this.images,
    required this.level,
    required this.idKel,
    required this.idKec,
    required this.status,
    required this.apiToken,
  });

  factory UsersModel.fromJson(Map<String, dynamic> json) => UsersModel(
        id: json["id"],
        nama: json["nama"],
        email: json["email"],
        images: json["images"],
        level: json["level"],
        idKel: json["id_kel"],
        idKec: json["id_kec"],
        status: json["status"],
        apiToken: json["api_token"],
      );
//maksudnya log jika mau print data
// login? atau menu data rekap dia sudah jalan karena programmer sblumnya buat 
  Map<String, dynamic> toJson() => {
        "id": id,
        "nama": nama,
        "email": email,
        "images": images,
        "level": level,
        "id_kel": idKel,
        "id_kec": idKec,
        "status": status,
        "api_token": apiToken,
      };
}
