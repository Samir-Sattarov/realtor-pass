import 'dart:async';

import 'package:flutter/material.dart';
import '../../../../app_core/app_core_library.dart';
import '../../presentation/cubit/auth/auth_sources/auth_sources_cubit.dart';
import '../models/token_response_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Future<UserModel> editCurrentUser(UserModel model);

  Future<TokenResponseModel> signIn({
    required String email,
    required String password,
  });

  Future<void> signUp({
    required String username,
    required String email,
  });
  Future<void> getCodeForEditUser({
    required String email,
  });

  Future<void> forgotPassword({
    required String email,
  });
  Future<void> confirmPassword(
      {required String newPassword, required String email});

  Future<TokenResponseModel> confirmOTP({
    required String code,
  });
  Future<void> confirmOTPForEditUser({
    required String code,
    required bool forgotPassword,
  });

  Future<UserModel> getCurrentUser(int userId);

  Future<String> authFromSource(AuthSource source);
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  final ApiClient client;

  AuthRemoteDataSourceImpl(this.client);

  @override
  Future<TokenResponseModel> signIn({
    required String email,
    required String password,
  }) async {
    final response = await client.post(ApiConstants.signIn, params: {
      "email": email,
      "password": password,
    });

    final model = TokenResponseModel.fromJson(response);

    return model;
  }

  @override
  Future<void> signUp({
    required String username,
    required String email,
  }) async {
    final response = await client.post(ApiConstants.signUp, params: {
      "email": email,
      "username": username,
    });

    print("Response $response");
  }

  @override
  Future<UserModel> getCurrentUser(int userId) async {
    final response = await client.get("${ApiConstants.currentUser}$userId/");

    print("resposne current user $response ");
    final model = UserModel.fromJson(response['data']);

    return model;
  }

  @override
  Future<TokenResponseModel> confirmOTP({required String code}) async {
    final response = await client.post(ApiConstants.otp, params: {
      "method": "checkCode",
      "data": {
        "code": int.parse(code),
      }
    });
    debugPrint("Response $response");

    final model = TokenResponseModel.fromJson(response);

    return model;
  }

  @override
  Future<UserModel> editCurrentUser(UserModel model) async {
    final response = await client.post(
      ApiConstants.otp,
      params: {
        "method": "setUser",
        "data": model.toJson(),
      },
    );

    final data =
        UserModel.fromJson(Map<String, dynamic>.from(response['data']));
    return data;
  }

  @override
  Future<void> forgotPassword({required String email}) async {
    await client.post(
      ApiConstants.otp,
      withParse: false,
      params: {
        "method": "forgotPassword",
        "data": {
          "email": email,
        },
      },
    );
  }

  @override
  Future<void> getCodeForEditUser({required String email}) async {
    await client.post(
      ApiConstants.otp,
      params: {
        "method": "changeUser",
        "data": {
          "email": email,
        }
      },
    );
  }

  @override
  Future<void> confirmOTPForEditUser(
      {required String code, required bool forgotPassword}) async {
    final Map<String, dynamic> data = {
      "code": int.parse(code),
    };

    if (forgotPassword) {
      data['forgotPassword'] = forgotPassword;
    }
    await client.post(
      ApiConstants.otp,
      params: {
        "method": "checkCode",
        "data": data,
      },
    );
  }

  @override
  Future<void> confirmPassword(
      {required String newPassword, required String email}) async {
    await client.post(
      ApiConstants.otp,
      params: {
        "method": "setUser",
        "data": {
          "password": newPassword,
          "userEmail": email,
        }
      },
    );
  }

  @override
  Future<String> authFromSource(AuthSource source) async {
    String response = "";
    switch (source) {
      case AuthSource.google:
        final resp = await client.get(
          ApiConstants.signInGoogle,
          getRealApi: true,
        );

        response = resp.toString();

        break;

      case AuthSource.facebook:
        final resp = await client.get(
          ApiConstants.signInFacebook,
          getRealApi: true,
        );
        response = resp.toString();

        break;

      case AuthSource.apple:
        final resp = await client.get(
          ApiConstants.signInApple,
          getRealApi: true,
        );

        response = resp.toString();

        break;
    }
    return response;
  }
}
