import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../resources/resources.dart';

class BackWidget extends StatelessWidget {
  final Function()? onBack;
  const BackWidget({Key? key, this.onBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBack ?? () => Navigator.pop(context),
      child: Container(
        width: 26.r,
        height: 26.r,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Color(0xffEBEBEB),
        ),
        child: Center(child: SvgPicture.asset(Svgs.tBack)),
      ),
    );
  }
}
