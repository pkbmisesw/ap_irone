import 'package:equatable/equatable.dart';

import 'item_profile_model.dart';

class ProfileModel extends Equatable {
  final bool? success;
  final List<ItemProfileModel>? data;
  final String? message;

  const ProfileModel({this.success, this.data, this.message});

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
        success: json['success'] as bool?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => ItemProfileModel.fromJson(e as Map<String, dynamic>))
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
