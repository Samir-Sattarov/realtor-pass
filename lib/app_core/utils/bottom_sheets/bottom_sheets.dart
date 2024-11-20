import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtor_pass/app_core/utils/bottom_sheets/support_body.dart';

import 'fav_conditions_body.dart';
import 'few_steps_body.dart';
import 'filter_body.dart';

class BottomSheets {

  static fewStepsBeforeRent(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      clipBehavior: Clip.antiAlias,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height / 1.5,
      ),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22.r),
        ),
        borderSide: const BorderSide(color: Color(0xffA1A1A1), width: 2),
      ),
      builder: (BuildContext context) {
        return const FewStepsBeforeRentBody();
      },
    );
  }
  static support(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      clipBehavior: Clip.antiAlias,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height / 1.5,
      ),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22.r),
        ),
        borderSide: const BorderSide(color: Color(0xffA1A1A1), width: 2),
      ),
      builder: (BuildContext context) {
        return const SupportBody();
      },
    );
  }


  static favConditions(BuildContext context, {required Function() onFillForm}) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: true,
        enableDrag: true,
        clipBehavior: Clip.antiAlias,
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height / 1.5,
        ),
        shape: OutlineInputBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
            borderSide: BorderSide(color: const Color(0xffA1A1A1), width: 2.w)),
        builder: (BuildContext context) {
          return FavorableConditionsBody(
            onFillForm: onFillForm,
          );
        });
  }

  static filter(
    BuildContext context, {
    required int category,
    required void Function(
      int mark,
      int category,
      int sort,
      int mileage,
      int consumption,
      int acceleration,
      int fromYear,
      int toYear,
      int maxPrice,
      int minPrice,
    ) onConfirm,
  }) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      isDismissible: true,
      enableDrag: true,
      clipBehavior: Clip.antiAlias,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height / 1.5,
      ),
      shape: OutlineInputBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(22.r),
        ),
        borderSide: const BorderSide(color: Color(0xffA1A1A1), width: 2),
      ),
      builder: (BuildContext context) {
        return FilterBody(
          category: category,
          onConfirm: (int category,
              int sort,
              int fromYear,
              int toYear,
              int maxPrice,
              int minPrice) {},
        );
      },
    );
  }
}
