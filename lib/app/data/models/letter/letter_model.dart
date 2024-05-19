import 'package:equatable/equatable.dart';

import 'item_letter_model.dart';

class LetterModel extends Equatable {
  final bool? success;
  final List<ItemLetterModel>? data;
  final String? message;

  const LetterModel({this.success, this.data, this.message});

  factory LetterModel.fromJson(Map<String, dynamic> json) => LetterModel(
        success: json['success'] as bool?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => ItemLetterModel.fromJson(e as Map<String, dynamic>))
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
