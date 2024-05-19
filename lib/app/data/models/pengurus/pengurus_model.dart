import 'package:equatable/equatable.dart';

import 'item_pengurus_model.dart';

class PengurusModel extends Equatable {
  final bool? success;
  final List<ItemPengurusModel>? data;
  final String? message;

  const PengurusModel({this.success, this.data, this.message});

  factory PengurusModel.fromJson(Map<String, dynamic> json) => PengurusModel(
        success: json['success'] as bool?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => ItemPengurusModel.fromJson(e as Map<String, dynamic>))
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
