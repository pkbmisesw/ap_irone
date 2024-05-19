import 'package:equatable/equatable.dart';

class Success extends Equatable {
  final String? token;
  final String? name;

  const Success({this.token, this.name});

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        token: json['token'] as String?,
        name: json['name'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'token': token,
        'name': name,
      };

  Success copyWith({
    String? token,
    String? name,
  }) {
    return Success(
      token: token ?? this.token,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [token, name];
}
