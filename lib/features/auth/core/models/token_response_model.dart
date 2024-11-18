import 'package:realtor_pass/features/auth/core/models/user_model.dart';

class TokenResponseModel {
  final UserModel? user;
  final String token;

  TokenResponseModel({this.user, required this.token});

  factory TokenResponseModel.fromJson(Map<String, dynamic> json) {
    return TokenResponseModel(
      user: json.containsKey('user') ? UserModel.fromJson(json['user']) : null,
      token: json['access_token'], // Убедитесь, что ключ соответствует ответу сервера
    );
  }
}
