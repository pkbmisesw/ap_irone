import 'package:equatable/equatable.dart';

import 'item_law_model.dart';

class LawModel extends Equatable {
  final bool? success;
  final List<ItemLawModel>? data;
  final String? message;

  const LawModel({this.success, this.data, this.message});

  factory LawModel.fromJson(Map<String, dynamic> json) => LawModel(
        success: json['success'] as bool?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => ItemLawModel.fromJson(e as Map<String, dynamic>))
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
