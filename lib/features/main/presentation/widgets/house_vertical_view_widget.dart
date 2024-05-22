import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtor_pass/features/main/core/entity/house_entity.dart';
import 'package:realtor_pass/features/main/presentation/widgets/house_widget.dart';

class HouseVerticalWidget extends StatelessWidget {
  final List<HouseEntity> houses;
  const HouseVerticalWidget({super.key, required this.houses});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      separatorBuilder: (context, index) => SizedBox(height: 8.w),
      addAutomaticKeepAlives: true,
      itemBuilder: (context, index) {
        final house = houses[index];

        return HouseWidget(
          houses: house,
        );
      },
      scrollDirection: Axis.vertical,
      itemCount: houses.length,
    );
  }
}
