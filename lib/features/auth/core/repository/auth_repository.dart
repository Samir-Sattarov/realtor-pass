import 'dart:async';

import 'package:dartz/dartz.dart';

import '../../../../app_core/app_core_library.dart';
import '../../presentation/cubit/auth/auth_sources/auth_sources_cubit.dart';
import '../entities/user_entity.dart';
import 'package:flutter/material.dart';

import '../datasources/auth_local_data_source.dart';
import '../datasources/auth_remote_data_source.dart';
import '../models/user_model.dart';

abstract class AuthRepository {
  Future<Either<AppError, void>> signIn({
    required String email,
    required String password,
  });

  Future<Either<AppError, bool>> checkActiveSession();
  Future<Either<AppError, UserEntity>> getCurrentUser();
  Future<Either<AppError, UserEntity>> editCurrentUser(UserEntity user);
  Future<Either<AppError, void>> confirmPassword(String password, String email);
  Future<Either<AppError, void>> forgotPassword(String email);

  Future<Either<AppError, void>> getCodeForEditUser(String email);
  Future<Either<AppError, void>> signUp({
    required String email,
    required String username,
    required String password
  });
  Future<Either<AppError, UserEntity>> confirmOtp({
    required String code,
  });

  Future<Either<AppError, void>> confirmOTPForEditUser(
      {required String code, required bool forgotPassword});

  Future<Either<AppError, String>> authFromSource(AuthSource source);
}

class AuthRepositoryImpl extends AuthRepository {
  final AuthLocalDataSource localDataSource;
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl(
    this.remoteDataSource,
    this.localDataSource,
  );

  @override
  Future<Either<AppError, void>> signIn(
      {required String email, required String password}) async {
    try {
      final response =
          await remoteDataSource.signIn(email: email, password: password);

      await localDataSource.saveToken(response.token);

      await localDataSource.saveUserId(response.user.id);

      return Right(Future.value(null));
    } catch (error) {
      return Left(
        AppError(
          appErrorType: AppErrorType.api,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<AppError, void>> signUp({
    required String email,
    required String username,
    required String password
  }) async {
    return action(
      task: remoteDataSource.signUp(email: email, username: username, password: password),
    );
  }

  @override
  Future<Either<AppError, bool>> checkActiveSession() async {
    try {
      final response = await localDataSource.checkActiveSession();

      return Right(response);
    } catch (error) {
      return Left(
        AppError(
          appErrorType: AppErrorType.api,
          errorMessage: error.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<AppError, UserEntity>> getCurrentUser() async {
    final userId = await localDataSource.getUserId();
    debugPrint("User id $userId");
    if (userId == null) return Right(UserEntity.empty());
    return action(
      task: remoteDataSource.getCurrentUser(userId),
    );
  }

  @override
  Future<Either<AppError, UserEntity>> confirmOtp(
      {required String code}) async {
    try {
      final response = await remoteDataSource.confirmOTP(code: code);

      await localDataSource.saveToken(response.token);
      await localDataSource.saveUserId(response.user.id);

      UserEntity updatedUser = response.user;
      updatedUser.isVerified;

      return Right(updatedUser);
    } catch (error) {
      return Left(AppError(
        appErrorType: AppErrorType.api,
        errorMessage: error.toString(),
      ));
    }
  }

  @override
  Future<Either<AppError, UserEntity>> editCurrentUser(UserEntity user) async {
    return action<UserEntity>(
      task: remoteDataSource.editCurrentUser(
        UserModel.fromEntity(user),
      ),
    );
  }

  @override
  Future<Either<AppError, void>> getCodeForEditUser(String email) async {
    return action(
      task: remoteDataSource.getCodeForEditUser(
        email: email,
      ),
    );
  }

  @override
  Future<Either<AppError, void>> confirmOTPForEditUser(
      {required String code, required bool forgotPassword}) async {
    return action(
      task: remoteDataSource.confirmOTPForEditUser(
        code: code,
        forgotPassword: forgotPassword,
      ),
    );
  }

  @override
  Future<Either<AppError, String>> authFromSource(AuthSource source) async {
    return action(task: remoteDataSource.authFromSource(source));
  }

  @override
  Future<Either<AppError, void>> confirmPassword(
      String password, String email) {
    return action<void>(
      task:
          remoteDataSource.confirmPassword(newPassword: password, email: email),
    );
  }

  @override
  Future<Either<AppError, void>> forgotPassword(String email) {
    return action(task: remoteDataSource.forgotPassword(email: email));
  }
}
