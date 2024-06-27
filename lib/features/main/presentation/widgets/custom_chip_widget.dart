import 'package:dartz/dartz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app_core/utils/app_style.dart';
import '../../core/entity/chip_entity.dart';

class CustomChipWidget extends StatelessWidget {
  final ChipEntity entity;
  final int currentIndex;

  const CustomChipWidget({super.key, required this.entity, required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    final isActive = currentIndex == entity.id;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 100),
      decoration: BoxDecoration(
          gradient: isActive ? const LinearGradient(
            colors: [AppStyle.blue, AppStyle.darkBlue],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ) : null,
          color: isActive ? null : const Color(0xffDADADA),
          borderRadius: BorderRadius.circular(100.r),
      ),
      padding: EdgeInsets.symmetric(horizontal: 22.w ),
      child: Center(
        child: Text(
          entity.title.tr(),
          style: TextStyle(
            color: isActive ? Colors.white : Colors.black,
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
