// ignore: unused_import
import 'dart:convert';

import 'user_model.dart';

class TokenResponseModel {
  final UserModel user;
  final String token;

  TokenResponseModel({required this.user, required this.token});

  factory TokenResponseModel.fromJson(Map<String, dynamic> json) {
    return TokenResponseModel(
      user: UserModel.fromJson(json['user']),
      token: json['accessToken'],
    );
  }
}
