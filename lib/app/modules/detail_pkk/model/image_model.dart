class ImageModel {
  final int id;
  final String pic;

  ImageModel({required this.id, required this.pic});

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(id: json['id'], pic: json['pic']);
  }
}
