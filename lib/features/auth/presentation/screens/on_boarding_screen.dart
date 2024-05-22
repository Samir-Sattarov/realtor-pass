import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtor_pass/app_core/app_core_library.dart';
import 'package:realtor_pass/features/main/presentation/screens/main_screen.dart';
import '../../../../app_core/utils/app_style.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../../../../resources/resources.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            Images.tOnBoardingImage,
            width: MediaQuery.of(context).size.width,
            height: 400.h,
          ),
          SizedBox(height: 32.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              "welcomeTo".tr(),
              style: TextStyle(
                fontStyle: FontStyle.italic,
                color: AppStyle.dark,
                fontSize: 20.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              "appName".tr(),
              style: TextStyle(
                color: AppStyle.blue,
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              "onBoardingDescription".tr(),
              style: TextStyle(
                color: const Color(0xff474747),
                fontSize: 16.sp,
              ),
            ),
          ),
          SizedBox(height: 98.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: ButtonWidget(
              title: "letsStarted".tr(),
              onTap: () {
                AnimatedNavigation.push(
                    context: context, page: const MainScreen());
              },
            ),
          ),
        ],
      ),
    );
  }
}
