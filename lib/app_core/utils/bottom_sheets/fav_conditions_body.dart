import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../features/main/core/entity/profitable_terms_entity.dart';
import '../../../features/main/presentation/cubit/profitable_terms/profitable_terms_cubit.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/error_flash_bar.dart';

class FavorableConditionsBody extends StatefulWidget {
  final Function() onFillForm;

  const FavorableConditionsBody({super.key, required this.onFillForm});

  @override
  State<FavorableConditionsBody> createState() =>
      _FavorableConditionsBodyState();
}

class _FavorableConditionsBodyState extends State<FavorableConditionsBody> {
  @override
  void initState() {
    BlocProvider.of<ProfitableTermsCubit>(context).load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfitableTermsCubit, ProfitableTermsState>(
      listener: (context, state) {
        if (state is ProfitableTermsError) {
          ErrorFlushBar(state.message).show(context);
        }
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          clipBehavior: Clip.antiAlias,
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
                "companyAdvantages".tr(),
                style: TextStyle(
                  color: const Color(0xff474747),
                  fontSize: 12.sp,
                ),
              ),
              SizedBox(height: 7.h),
              Text(
                "favConditions".tr(),
                style: TextStyle(
                  color: const Color(0xff474747),
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 7.h),
              Text(
                "chooseTheRightTransport".tr(),
                style:
                TextStyle(color: const Color(0xff474747), fontSize: 12.sp),
              ),
              SizedBox(height: 33.h),
              BlocBuilder<ProfitableTermsCubit, ProfitableTermsState>(
                builder: (context, state) {
                  if (state is ProfitableTermsLoaded) {
                    final items = state.entity.terms;
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
              SizedBox(height: 35.h),
              ButtonWidget(
                title: "fillTheForm".tr(),
                onTap: widget.onFillForm,
              ),
              SizedBox(height: 35.h),
            ],
          ),
        ),
      ),
    );
  }

  _itemView(ProfitableTermsEntity entity, int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 17.5.r,
          height: 17.5.r,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.black,
          ),
        ),
        SizedBox(
          width: 17.5.w,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              entity.title.tr(),
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14.sp,
                color: const Color(0xff474747),
              ),
            ),
            SizedBox(height: 7.h),
            Text(
              entity.description.tr(),
              style: TextStyle(
                fontSize: 10.sp,
                color: const Color(0xff474747),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
