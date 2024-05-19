import 'package:equatable/equatable.dart';

import 'item_article_model.dart';

class ArticleModel extends Equatable {
  final bool? success;
  final List<ItemArticleModel>? data;
  final String? message;

  const ArticleModel({this.success, this.data, this.message});

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        success: json['success'] as bool?,
        data: (json['data'] as List<dynamic>?)
            ?.map((e) => ItemArticleModel.fromJson(e as Map<String, dynamic>))
            .toList(),
        message: json['message'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'success': success,
        'data': data?.map((e) => e.toJson()).toList(),
        'message': message,
      };

  ArticleModel copyWith({
    bool? success,
    List<ItemArticleModel>? data,
    String? message,
  }) {
    return ArticleModel(
      success: success ?? this.success,
      data: data ?? this.data,
      message: message ?? this.message,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [success, data, message];
}
