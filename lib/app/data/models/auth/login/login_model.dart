import 'package:silahan_kawan/app/data/models/auth/login/users_model.dart';

class LoginModel {
  final String token;
  final bool error;
  final UsersModel? users;

  LoginModel({
    required this.token,
    required this.error,
    required this.users,
  });

  factory LoginModel.fromJson(Map<String, dynamic> json) => LoginModel(
        token: json["token"],
        error: json["error"],
        users: UsersModel.fromJson(json["users"]),
      );

  Map<String, dynamic> toJson() => {
        "token": token,
        "error": error,
        "users": users?.toJson(),
      };
}
