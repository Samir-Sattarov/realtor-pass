import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realtor_pass/features/main/presentation/screens/profile_screen.dart';
import '../../../../app_core/utils/animated_navigation.dart';
import '../../../../resources/resources.dart';
import '../../../auth/presentation/cubit/session/session_cubit.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';
import '../cubit/bottom_nav/bottom_nav_cubit.dart';
import 'catalog_screen.dart';
import 'favorite_screen.dart';
import 'home_screen.dart';
import 'listing_screen.dart';

class MainScreen extends StatefulWidget {
  final int? index;

  const MainScreen({super.key, this.index});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int currentIndex;

  List<Widget> screens = [
    const HomeScreen(),
    const CatalogScreen(),
    const ListingScreen(),
    const FavoriteScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    currentIndex = widget.index ?? 0;
    BlocProvider.of<SessionCubit>(context).checkSession();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<BottomNavCubit, int>(
        listener: (context, state) {
          if (state != -1) {
            if (mounted) {
              Future.delayed(
                Duration.zero,
                () => setState(() => currentIndex = state),
              );
            }
          }
        },
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          switchInCurve: Curves.easeIn,
          switchOutCurve: Curves.easeOut,
          child: screens[currentIndex],
        ),
      ),
      bottomNavigationBar: Container(
        height: 98.h,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        padding: EdgeInsets.only(top: 15.h),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _item(0, title: "home".tr(), image: Svgs.tHome,),
              _item(1, title: "catalog".tr(), image: Svgs.tCompass),
              _item(2, title: "addHouse".tr(), image: Svgs.tAdd),
              _item(
                3,
                title: "favorite".tr(),
                image: Svgs.tFavorite,
                onTap: () {
                  if (BlocProvider.of<SessionCubit>(context).state
                      is SessionDisabled) {
                    AnimatedNavigation.push(
                        context: context, page: const SignInScreen());
                  } else {
                    setState(() => currentIndex = 2);
                  }
                },
              ),
              _item(
                4,
                title: "profile".tr(),
                image: Svgs.tProfile,
                onTap: () {
                  print(
                      "State 3 ${BlocProvider.of<SessionCubit>(context).state}");

                  if (BlocProvider.of<SessionCubit>(context).state
                      is SessionDisabled) {
                    AnimatedNavigation.push(
                        context: context, page: const SignInScreen());
                  } else {
                    setState(() => currentIndex = 3);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  _item(
    int index, {
    Function()? onTap,
    required String title,
    required String image,
  }) {
    final isActive = currentIndex == index;
    final color = isActive ? const Color(0xff175148) : const Color(0xff7D8588);

    return GestureDetector(
      onTap: onTap ?? () => setState(() => currentIndex = index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        width: 46.w,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              child: Center(
                child: SvgPicture.asset(
                  image,
                  width: 25,
                  height: 25,
                  // ignore: deprecated_member_use
                  color: color,
                ),
              ),
            ),
            SizedBox(height: 6.h),
            FittedBox(
              child: AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 300),
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: isActive ? FontWeight.w500 : FontWeight.normal,
                  color: color,
                ),
                child: Text(
                  title.tr(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
