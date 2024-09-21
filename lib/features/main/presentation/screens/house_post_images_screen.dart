import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/entity/house_post_entity.dart';

class HousePostImagesScreen extends StatefulWidget {
  final HousePostEntity postEntity;
  const HousePostImagesScreen({super.key, required this.postEntity});

  @override
  State<HousePostImagesScreen> createState() =>
      _HousePostImagesScreenState();
}

class _HousePostImagesScreenState extends State<HousePostImagesScreen> {
  late HousePostEntity entity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "addSomePhoto".tr(),
                  style: TextStyle(
                    fontSize: 21.sp,
                    letterSpacing: 0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: 5.h,),

                Text(
                  "youNeed5Photos".tr(),
                  style: TextStyle(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                SizedBox(height: 50.h,),


              ],
            ),
          ),
        ),
      ),
    );
  }
}

