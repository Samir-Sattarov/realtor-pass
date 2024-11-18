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
    required String role,
  });

  Future<Either<AppError, bool>> checkActiveSession();
  Future<Either<AppError, UserEntity>> getCurrentUser();
  Future<Either<AppError, UserEntity>> editCurrentUser(UserEntity user);
  Future<Either<AppError, void>> confirmPassword(String password, String email);
  Future<Either<AppError, void>> forgotPassword(String email);
  Future<Either<AppError, void>> logOut();


  Future<Either<AppError, void>> getCodeForEditUser(String email);
  Future<Either<AppError, void>> signUp({
    required String email,
    required String username,
    required String password,
    required String role,
    required String phone

  });
  Future<Either<AppError, UserEntity>> confirmOtp({
    required String code,
    required String email
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
  Future<Either<AppError, void>> signIn({
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      final response = await remoteDataSource.signIn(
        email: email,
        password: password,
        role: role,
      );

      await localDataSource.saveToken(response.token);



      return const Right(null);
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
    required String password,
    required String role,
    required String phone

  }) async {
    return action(
      task: remoteDataSource.signUp(email: email, username: username, password: password, role: role, phone: phone),
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
    return action(
      task: remoteDataSource.getCurrentUser(),
    );
  }

  Future<Either<AppError, UserEntity>> confirmOtp({
    required String code,
    required String email,
  }) async {
    try {
      final response = await remoteDataSource.confirmOTP(code: code, email: email);

      await localDataSource.saveToken(response.token);

      if (response.user != null) {
        await localDataSource.saveUserId(response.user!.id);
        UserEntity updatedUser = response.user!;
        return Right(updatedUser);
      } else {
        return const Left(AppError(
          appErrorType: AppErrorType.api,
          errorMessage: "User data is missing in the response.",
        ));
      }
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

  @override
  Future<Either<AppError, void>> logOut() async {
    await localDataSource.logOut();
    return const Right(null);
  }
}
