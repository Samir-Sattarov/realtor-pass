import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_style.dart';


class ButtonWidget extends StatelessWidget {
  final String title;
  final Widget? customWidget;
  final Function() onTap;
  final bool isEnabled;
  final Color? color;
  final double height;
  const ButtonWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.color,
    this.customWidget,
    this.height = 47,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onTap : null,
        borderRadius: BorderRadius.circular(65.r),
        child: Ink(
          height: height.h,
          width:  MediaQuery.of(context).size.width ,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(65.r),
            color: isEnabled ? null : AppStyle.blue,
            gradient: isEnabled ? const LinearGradient(
              colors: [AppStyle.blue, AppStyle.darkBlue],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ) : null, // No gradient if not enabled
          ),
          child: Center(
            child: customWidget ?? Text(
              title.tr(),
              style: TextStyle(
                fontSize: 16.sp,
                color:
                    isEnabled == false ? const Color(0xff747E83) : Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
