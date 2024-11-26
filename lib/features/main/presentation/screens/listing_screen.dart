import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../../../../resources/resources.dart';
import '../../core/entity/house_post_entity.dart';
import 'house_post_images_screen.dart';
import 'house_post_screen.dart';

class ListingScreen extends StatefulWidget {
  final HousePostEntity entity;
  const ListingScreen({super.key, required this.entity});

  @override
  State<ListingScreen> createState() => _ListingScreenState();
}

class _ListingScreenState extends State<ListingScreen> {
  @override
  Widget build(BuildContext context) {
    final housePostEntity = widget.entity;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 20.w,
                    ),
                  ],
                ),
                SizedBox(
                  height: 120.h,
                ),
                Image.asset(
                  Images.tFavConditions,
                  height: 200.h,
                ),
                SizedBox(height: 20.h),
                Text(
                  "You don't have any listings yet".tr(),
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 10.h),
                Text(
                  "Create a listing with RealPass Setup and start getting booked."
                      .tr(),
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 30.h),
                Container(
                    width: 300,
                    child: ButtonWidget(
                        title: "getStarted".tr(),
                        onTap: () {
                        }))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
