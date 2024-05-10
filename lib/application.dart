import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'features/auth/presentation/cubit/auth/auth_sources/auth_sources_cubit.dart';
import 'features/auth/presentation/cubit/current_user/current_user_cubit.dart';
import 'features/auth/presentation/cubit/registration/registration_cubit.dart';
import 'features/auth/presentation/cubit/session/session_cubit.dart';
import 'features/auth/presentation/screens/home_screen.dart';
import 'locator.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

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

  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(value: authCubit),
        BlocProvider.value(value: authSourcesCubit),
        BlocProvider.value(value: registrationCubit),
        BlocProvider.value(value: currentUserCubit..load()),
        BlocProvider.value(value: sessionCubit..checkSession()),
      ],
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: false,
        builder: (context, child) {
          return MaterialApp(
            title: 'Royal Pass Car',
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
        child: const HomeScreen(),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
