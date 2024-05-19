import 'package:equatable/equatable.dart';

class ItemBannerModel extends Equatable {
  final int? id;
  final String? slider;

  const ItemBannerModel({this.id, this.slider});

  factory ItemBannerModel.fromJson(Map<String, dynamic> json) =>
      ItemBannerModel(
        id: json['id'] as int?,
        slider: json['slider'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'slider': slider,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, slider];
}
