import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:get_it/get_it.dart';

import 'app_core/app_core_library.dart';
import 'app_core/cubits/network/network_cubit.dart';
import 'features/auth/core/datasources/auth_local_data_source.dart';
import 'features/auth/core/datasources/auth_remote_data_source.dart';
import 'features/auth/core/repository/auth_repository.dart';
import 'features/auth/core/usecases/auth_usecases.dart';
import 'features/auth/core/usecases/confirm_otp_usecase.dart';
import 'features/auth/core/usecases/confirm_password_usecase.dart';
import 'features/auth/core/usecases/forgot_password_usecase.dart';
import 'features/auth/core/usecases/registration_usecase.dart';
import 'features/auth/core/usecases/session_usecases.dart';
import 'features/auth/core/usecases/user_usecases.dart';
import 'features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'features/auth/presentation/cubit/auth/auth_sources/auth_sources_cubit.dart';
import 'features/auth/presentation/cubit/confitm_password/confirm_password_cubit.dart';
import 'features/auth/presentation/cubit/current_user/current_user_cubit.dart';
import 'features/auth/presentation/cubit/edit_current_user_cubit/edit_user_cubit.dart';
import 'features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import 'features/auth/presentation/cubit/otp_code/otp_code_cubit.dart';
import 'features/auth/presentation/cubit/registration/registration_cubit.dart';
import 'features/auth/presentation/cubit/session/session_cubit.dart';

final locator = GetIt.I;

final cacheInterseptorOptions = CacheOptions(
  store: MemCacheStore(),
  policy: CachePolicy.refreshForceCache,
  maxStale: const Duration(days: 7),
  priority: CachePriority.high,
  keyBuilder: CacheOptions.defaultCacheKeyBuilder,
  allowPostMethod: false,
);

void setup() {
  // ================ Core ================ //

  locator.registerLazySingleton(() => Dio()
    ..interceptors.add(DioCacheInterceptor(options: cacheInterseptorOptions)));
  locator.registerLazySingleton<ApiClient>(
      () => ApiClientImpl(locator(), locator()));

  // ================ UseCases ================ //

  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl());
  locator.registerLazySingleton(() => CheckActiveSession(locator()));
  locator.registerLazySingleton(() => AuthSourceUsecase(locator()));
  locator.registerLazySingleton(() => LoginUsecase(locator()));
  locator.registerLazySingleton(() => GetCurrentUserUsecase(locator()));
  locator.registerLazySingleton(() => RegistrationUsecase(locator()));
  locator.registerLazySingleton(() => ConfirmOTPUsecase(locator()));
  locator.registerLazySingleton(() => ConfirmOTPForEditUserUsecase(locator()));
  locator.registerLazySingleton(() => EditCurrentUserUsecase(locator()));
  locator.registerLazySingleton(() => GetCodeForEditUserUsecase(locator()));
  locator.registerLazySingleton(() => ForgotPasswordUsecase(locator()));
  locator.registerLazySingleton(() => ConfirmPasswordUsecase(locator()));





  // ================ External ================ //

  locator.registerLazySingleton(() => SecureStorage());
  locator.registerLazySingleton(() => StorageService());

  // ================ BLoC / Cubit ================ //

  locator.registerFactory(() => OtpCodeCubit(
        locator(),
        locator(),
        locator(),
        locator(),
      ));

  locator.registerFactory(() => AuthSourcesCubit(
        locator(),
      ));

  locator.registerFactory(() => NetworkCubit(
        locator(),
      ));
  locator.registerFactory(() => EditUserCubit(
        locator(),
        locator(),
        locator(),
      ));
  locator.registerFactory(() => ForgotPasswordCubit(
    locator(),
  ));
  locator.registerFactory(() => ConfirmPasswordCubit(
    locator(),

  ));
  locator.registerFactory(() => AuthCubit(
        locator(),
        locator(),
      ));

  locator.registerFactory(() => CurrentUserCubit(
        locator(),
      ));

  locator.registerFactory(() => RegistrationCubit(
        locator(),
      ));
  locator.registerFactory(() => SessionCubit(
        locator(),
      ));





  // ================ Cars ================ //







  // ================ Repository / Datasource ================ //

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      locator(),
      locator(),
    ),
  );



  // ================ DATASOURCE ================ //

  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(locator()));

  locator.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(locator()));


}
