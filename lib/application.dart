import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtor_pass/features/main/presentation/cubit/bottom_nav/bottom_nav_cubit.dart';
import 'package:realtor_pass/features/main/presentation/cubit/house_type/house_type_cubit.dart';
import 'package:realtor_pass/features/main/presentation/cubit/houses/houses_cubit.dart';
import 'package:realtor_pass/features/main/presentation/screens/main_screen.dart';
import 'features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'features/auth/presentation/cubit/auth/auth_sources/auth_sources_cubit.dart';
import 'features/auth/presentation/cubit/confitm_password/confirm_password_cubit.dart';
import 'features/auth/presentation/cubit/current_user/current_user_cubit.dart';
import 'features/auth/presentation/cubit/edit_current_user_cubit/edit_user_cubit.dart';
import 'features/auth/presentation/cubit/forgot_password/forgot_password_cubit.dart';
import 'features/auth/presentation/cubit/otp_code/otp_code_cubit.dart';
import 'features/auth/presentation/cubit/registration/registration_cubit.dart';
import 'features/auth/presentation/cubit/session/session_cubit.dart';
import 'features/main/presentation/cubit/config/config_cubit.dart';
import 'features/main/presentation/cubit/favorite/favorite_cubit.dart';
import 'features/main/presentation/cubit/favorite/favorite_json/favorite_houses_json_cubit.dart';
import 'features/main/presentation/cubit/few_steps/few_steps_cubit.dart';
import 'features/main/presentation/cubit/house_selling_type/house_selling_type_cubit.dart';
import 'features/main/presentation/cubit/house_stuff/house_stuff_cubit.dart';
import 'features/main/presentation/cubit/post_house/house_post_cubit.dart';
import 'features/main/presentation/cubit/posters/posters_cubit.dart';
import 'features/main/presentation/cubit/profitable_terms/profitable_terms_cubit.dart';
import 'features/main/presentation/cubit/questions/questions_cubit.dart';
import 'features/main/presentation/cubit/support/support_cubit.dart';
import 'features/main/presentation/cubit/upload_photos/upload_photos_cubit.dart';
import 'locator.dart';

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application>
    with AutomaticKeepAliveClientMixin {
  late AuthCubit authCubit;
  late AuthSourcesCubit authSourcesCubit;
  late CurrentUserCubit currentUserCubit;
  late SessionCubit sessionCubit;
  late RegistrationCubit registrationCubit;
  late BottomNavCubit bottomNavCubit;
  late HousesCubit housesCubit;
  late HouseTypeCubit houseTypeCubit;
  late EditUserCubit editUserCubit;
  late PostersCubit postersCubit;
  late QuestionsCubit questionsCubit;
  late FewStepsCubit fewStepsCubit;
  late ProfitableTermsCubit profitableTermsCubit;
  late ConfigCubit configCubit;
  late SupportCubit supportCubit;
  late OtpCodeCubit otpCodeCubit;
  late HouseStuffCubit stuffCubit;
  late HousePostCubit postCubit;
  late UploadPhotosCubit uploadPhotosCubit;
  late ForgotPasswordCubit forgotPasswordCubit;
  late HouseSellingTypeCubit houseSellingTypeCubit;
  late FavoriteHousesCubit favoriteHousesCubit;
  late FavoriteHousesJsonCubit favoriteHousesJsonCubit;
  late ConfirmPasswordCubit confirmPasswordCubit;


  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() {
    registrationCubit = locator();
    authSourcesCubit = locator();
    authCubit = locator();
    currentUserCubit = locator();
    sessionCubit = locator();
    bottomNavCubit = locator();
    housesCubit = locator();
    houseTypeCubit = locator();
    editUserCubit = locator();
    postersCubit = locator();
    questionsCubit = locator();
    fewStepsCubit = locator();
    profitableTermsCubit =  locator();
    configCubit = locator();
    supportCubit = locator();
    otpCodeCubit =  locator();
    stuffCubit =  locator();
    postCubit = locator();
    forgotPasswordCubit = locator();
    houseSellingTypeCubit = locator();
    favoriteHousesCubit = locator();
    favoriteHousesJsonCubit =  locator();
    uploadPhotosCubit =  locator();
    confirmPasswordCubit =  locator();


  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authCubit),
        BlocProvider.value(value: authSourcesCubit),
        BlocProvider.value(value: registrationCubit),
        BlocProvider.value(value: currentUserCubit..load()),
        BlocProvider.value(value: sessionCubit..checkSession()),
        BlocProvider.value(value: bottomNavCubit),
        BlocProvider.value(value: housesCubit),
        BlocProvider.value(value: uploadPhotosCubit),
        BlocProvider.value(value: houseTypeCubit),
        BlocProvider.value(value: editUserCubit),
        BlocProvider.value(value: postersCubit),
        BlocProvider.value(value: questionsCubit),
        BlocProvider.value(value: fewStepsCubit),
        BlocProvider.value(value: profitableTermsCubit),
        BlocProvider.value(value: configCubit..load()),
        BlocProvider.value(value: supportCubit),
        BlocProvider.value(value: otpCodeCubit),
        BlocProvider.value(value: stuffCubit),
        BlocProvider.value(value: postCubit),
        BlocProvider.value(value: forgotPasswordCubit),
        BlocProvider.value(value: houseSellingTypeCubit..load(locale: context.locale.languageCode)),
        BlocProvider.value(value: favoriteHousesCubit),
        BlocProvider.value(value: favoriteHousesJsonCubit),
        BlocProvider.value(value: confirmPasswordCubit),


      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: false,
        builder: (context, child) {
          return MaterialApp(
            title: 'Realtor Pass House',
            debugShowCheckedModeBanner: false,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            theme: ThemeData(
              fontFamily: "SuisseIntl",
              primarySwatch: Colors.green,
              splashColor: Colors.transparent,
              textButtonTheme: TextButtonThemeData(
                style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                ),
              ),
              highlightColor: Colors.transparent,
            ),
            home: child,
          );
        },
        child:  const MainScreen(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
