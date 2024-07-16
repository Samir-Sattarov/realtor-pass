import 'package:dio/dio.dart';
import 'package:dio_cache_interceptor/dio_cache_interceptor.dart';
import 'package:get_it/get_it.dart';
import 'package:realtor_pass/features/main/core/datasources/main_remote_data_source.dart';
import 'package:realtor_pass/features/main/core/repository/main_repository.dart';
import 'package:realtor_pass/features/main/core/usecases/houses_usecase.dart';
import 'package:realtor_pass/features/main/presentation/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:realtor_pass/features/main/presentation/cubit/house_type/house_type_cubit.dart';
import 'package:realtor_pass/features/main/presentation/cubit/houses/houses_cubit.dart';

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
import 'features/main/core/usecases/config_usecase.dart';
import 'features/main/core/usecases/feedback_usecase.dart';
import 'features/main/core/usecases/few_steps_usecase.dart';
import 'features/main/core/usecases/get_house_stuff_usecase.dart';
import 'features/main/core/usecases/posters_usecase.dart';
import 'features/main/core/usecases/profitable_terms_usecase.dart';
import 'features/main/core/usecases/questions_usecase.dart';
import 'features/main/presentation/cubit/config/config_cubit.dart';
import 'features/main/presentation/cubit/few_steps/few_steps_cubit.dart';
import 'features/main/presentation/cubit/house_stuff/house_stuff_cubit.dart';
import 'features/main/presentation/cubit/posters/posters_cubit.dart';
import 'features/main/presentation/cubit/profitable_terms/profitable_terms_cubit.dart';
import 'features/main/presentation/cubit/questions/questions_cubit.dart';
import 'features/main/presentation/cubit/support/support_cubit.dart';

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
  locator.registerLazySingleton(() => GetHousesUsecase(locator()));
  locator.registerLazySingleton(() => GetHouseTypeUsecase(locator()));
  locator.registerLazySingleton(() => GetPostersUsecase(locator()));
  locator.registerLazySingleton(() => QuestionsUsecase(locator()));
  locator.registerLazySingleton(() => GetHouseStuffUsecase(locator()));

  locator.registerLazySingleton(() => GetFewStepsUsecase(
        locator(),
      ));
  locator.registerLazySingleton(() => GetProfitableTermsUsecase(
        locator(),
      ));
  locator.registerLazySingleton(() => GetConfigUsecase(
        locator(),
      ));
  locator.registerLazySingleton(() => FeedbackUsecase(
        locator(),
      ));

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
  locator.registerFactory(() => BottomNavCubit());
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

  // ================ Houses ================ //
  locator.registerFactory(() => HousesCubit(
        locator(),
      ));
  locator.registerFactory(() => HouseTypeCubit(
        locator(),
      ));
  locator.registerFactory(() => PostersCubit(
        locator(),
      ));
  locator.registerFactory(() => QuestionsCubit(
        locator(),
      ));
  locator.registerFactory(() => FewStepsCubit(
        locator(),
      ));
  locator.registerFactory(() => ProfitableTermsCubit(locator()));
  locator.registerFactory(() => ConfigCubit(locator()));
  locator.registerFactory(() => SupportCubit(locator()));
  locator.registerFactory(() => HouseStuffCubit(locator()));


  // ================ Repository / Datasource ================ //

  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(
      locator(),
      locator(),
    ),
  );
  locator.registerLazySingleton<MainRepository>(
    () => MainRepositoryImpl(
      locator(),
    ),
  );
  // ================ DATASOURCE ================ //

  locator.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(locator()));

  locator.registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(locator()));
  locator.registerLazySingleton<MainRemoteDataSource>(
      () => MainRemoteDataSourceImpl(locator()));
}
