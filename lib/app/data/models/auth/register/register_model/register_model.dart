import 'package:equatable/equatable.dart';

import 'success.dart';

class RegisterModel extends Equatable {
  final Success? success;
  // final Error? error;

  const RegisterModel({
    this.success,
    // this.error,
  });

  factory RegisterModel.fromJson(Map<String, dynamic> json) => RegisterModel(
        success: json['success'] == null
            ? null
            : Success.fromJson(json['success'] as Map<String, dynamic>),
        // error: json['error'] == null
        //     ? null
        //     : Error.fromJson(json['error'] as Map<String, dynamic>),
      );

  Map<String, dynamic> toJson() => {
        'success': success?.toJson(),
        // 'error': error?.toJson(),
      };

  RegisterModel copyWith({
    Success? success,
  }) {
    return RegisterModel(
      success: success ?? this.success,
      // error: error ?? this.error,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
        success,
        //  error,
      ];
}
