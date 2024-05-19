import 'package:equatable/equatable.dart';

import 'item_banner_model.dart';

class BannerModel extends Equatable {
  final bool? success;
  final List<ItemBannerModel>? data;
  final String? message;

  const BannerModel({this.success, this.data, this.message});

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        success: json['success'] as bool?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => ItemBannerModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.map((e) => e.toJson()).toList(),
        'message': message,
      };

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [success, data, message];
}
