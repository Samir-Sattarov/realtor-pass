import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../app_core/utils/bottom_sheets/bottom_sheets.dart';
import '../../../../resources/resources.dart';
import '../../../auth/presentation/cubit/auth/auth_cubit.dart';
import '../../../auth/presentation/cubit/current_user/current_user_cubit.dart';
import '../../../auth/presentation/cubit/session/session_cubit.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    BlocProvider.of<CurrentUserCubit>(context).load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthLogOutSuccess) {
            BlocProvider.of<CurrentUserCubit>(context).load();
            BlocProvider.of<SessionCubit>(context).checkSession();
          }
        },
        child: BlocBuilder<CurrentUserCubit, CurrentUserState>(
          builder: (context, state) {
            return SafeArea(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 25.h),
                        Text(
                          BlocProvider.of<CurrentUserCubit>(context)
                              .user
                              .username,
                          style: TextStyle(
                            color: const Color(0xff1A1E25),
                            fontWeight: FontWeight.bold,
                            fontSize: 24.sp,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          BlocProvider.of<CurrentUserCubit>(context).user.email,
                          style: TextStyle(
                            color: const Color(0xff7D7F88),
                            fontWeight: FontWeight.bold,
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(height: 30.h),
                        Container(
                            height: 1,
                            width: MediaQuery.of(context).size.width,
                            color: const Color(0xffA1A1A1)),
                        SizedBox(height: 24.h),
                        _profileItem(
                          svgPath: Svgs.tUserCircle,
                          title: "profile".tr(),
                          onTap: () {},
                        ),
                        SizedBox(height: 16.h),
                        _profileItem(
                          svgPath: Svgs.tHome,
                          title: "applications".tr(),
                          onTap: () {},
                        ),
                        SizedBox(height: 16.h),
                        _profileItem(
                          svgPath: Svgs.tHelpCircle,
                          title: "support".tr(),
                          onTap: () {
                            BottomSheets.support(context);
                          },
                        ),
                        SizedBox(height: 16.h),
                        _profileItem(
                          svgPath: Svgs.tSettings,
                          title: "settings".tr(),
                          onTap: () {
                            AnimatedNavigation.push(
                                context: context, page: const SettingsScreen());
                          },
                        ),
                        SizedBox(height: 16.h),
                        _profileItem(
                          svgPath: Svgs.tLogOut,
                          title: "logOut".tr(),
                          onTap: () {},
                          color: Colors.red,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  _profileItem({
    required String svgPath,
    Color color = const Color(0xff474747),
    required String title,
    required Function() onTap,
  }) {
    return TextButton(
      onPressed: onTap,
      child: Row(
        children: [
          SizedBox(
            height: 24.r,
            width: 24.r,
            child: Center(
              child: SvgPicture.asset(
                svgPath,
                color: color,
              ),
            ),
          ),
          SizedBox(width: 8.w),
          Text(
            title,
            style: TextStyle(
              color: color,
              fontSize: 16.sp,
            ),
          ),
          const Spacer(),
          SizedBox(
            height: 24.r,
            width: 24.r,
            child: Center(
              child: SvgPicture.asset(
                Svgs.tChevronRight,
                color: color,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
