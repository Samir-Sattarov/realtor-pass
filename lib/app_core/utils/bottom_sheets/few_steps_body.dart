import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/main/core/entity/few_steps_entity.dart';
import '../../../features/main/presentation/cubit/few_steps/few_steps_cubit.dart';
import '../../app_core_library.dart';
import '../../widgets/error_flash_bar.dart';

class FewStepsBeforeRentBody extends StatefulWidget {
  const FewStepsBeforeRentBody({super.key});

  @override
  State<FewStepsBeforeRentBody> createState() => _FewStepsBeforeRentBodyState();
}

class _FewStepsBeforeRentBodyState extends State<FewStepsBeforeRentBody> {
  @override

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: BlocListener<FewStepsCubit, FewStepsState>(
        bloc: BlocProvider.of<FewStepsCubit>(context)..load(locale: context.locale.languageCode),

        listener: (context, state) {
          if (state is FewStepsError) {
            ErrorFlushBar(state.message).show(context);
          }
        },
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 24.h),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.h),
                Text(
                  "howItAllHappens".tr(),
                  style: TextStyle(
                    color: const Color(0xff474747),
                    fontSize: 12.sp,
                  ),
                ),
                SizedBox(height: 7.h),
                Text(
                  "severalImportantStagesBeforeRentHouse".tr(),
                  style: TextStyle(
                    color: const Color(0xff474747),
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 7.h),
                Text(
                  "theStepsThatWeDescribe".tr(),
                  style: TextStyle(
                      color: const Color(0xff474747), fontSize: 12.sp),
                ),
                SizedBox(height: 17.h),
                Container(
                  height: 1.h,
                  color: const Color(0xff808080),
                ),
                SizedBox(height: 24.h),
                BlocBuilder<FewStepsCubit, FewStepsState>(
                  builder: (context, state) {
                    if (state is FewStepsLoaded) {
                      print("Loaded");
                      final items = state.fewStepsResultEntity.steps;
                      return ListView.builder(
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          final entity = items[index];
                          return _itemView(entity, index);
                        },
                        itemCount: items.length,
                        physics: const NeverScrollableScrollPhysics(),
                      );
                    }

                    return const SizedBox();
                  },
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _itemView(FewStepsEntity entity, int index) {
    return Padding(
      padding: EdgeInsets.only(bottom: 38.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 10.w,
              vertical: 4.h,
            ),
            decoration: BoxDecoration(
              color: AppStyle.blue,
              borderRadius: BorderRadius.circular(88.r),
            ),
            child: Center(
              child: Text(
                "$index ${"step".tr()}",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.sp,
                ),
              ),
            ),
          ),
          SizedBox(width: 28.w),
          Expanded(
            child: Text(
              entity.title,
              style: TextStyle(
                fontSize: 14.sp,
                color: const Color(0xff474747),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
