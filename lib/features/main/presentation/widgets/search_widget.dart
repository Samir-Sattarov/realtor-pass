import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../resources/resources.dart';

class SearchWidget<T> extends StatelessWidget {
  final TextEditingController controller;
  final Function(String value) onSearch;
  final Function()? onFilter;
  final String? hintText;
  final Future<List<T>?> Function(String search) suggestionsCallback;
  final Widget Function(BuildContext context, T value) itemBuilder;
  final Function(String)? onSelect;

  const SearchWidget({
    super.key,
    required this.controller,
    required this.onSearch,
    this.onFilter,
    required this.suggestionsCallback,
    required this.itemBuilder,
    this.onSelect,
    this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 51.h,
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(
                left: 24.w,
                right: 10.w,
                bottom: 8.h,
                top: 8.h,
              ),
              decoration: BoxDecoration(
                color: const Color(0xffF2F2F2),
                borderRadius: BorderRadius.circular(25.r),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TypeAheadField<T>(
                      offset: const Offset(0, 12),
                      hideOnEmpty: true,
                      debounceDuration: const Duration(milliseconds: 200),
                      emptyBuilder: (context) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("${"empty".tr()}..."),
                      ),
                      constraints: BoxConstraints(
                          maxHeight: 300.h, minWidth: 1.sw, maxWidth: 1.sw),
                      controller: controller,
                      itemBuilder: itemBuilder,
                      builder: (context, localController, focusNode) {
                        return TextField(
                          focusNode: focusNode,
                          decoration: InputDecoration(
                            hintStyle: TextStyle(
                                fontSize: 14.sp,
                                color: const Color(0xffA1A1A1)),
                            hintText: hintText ?? "Lamborgini, BMW",
                            contentPadding: EdgeInsets.zero,
                            border: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                          ),
                          onSubmitted: onSearch,
                          controller: localController,
                        );
                      },
                      onSelected: (T? value) {
                        if (value != null) {
                          controller.text = value.toString();
                          onSelect?.call(value.toString());
                        }
                      },
                      suggestionsCallback: suggestionsCallback,
                    ),
                  ),
                  SizedBox(width: 8.w),
                  GestureDetector(
                    onTap: () => onSearch.call(controller.text),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [AppStyle.blue, AppStyle.darkBlue],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(18.r),
                      ),
                      child: Center(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.search,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 3.w,
                            ),
                            Text(
                              "search".tr(),
                              style: TextStyle(
                                color: Colors.white,
                                height: -0.1,
                                fontSize: 14.sp,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          onFilter == null ? const SizedBox() : SizedBox(width: 8.w),
          onFilter == null
              ? const SizedBox()
              : GestureDetector(
                  onTap: onFilter,
                  child: SvgPicture.asset(
                    Svgs.tFilter,
                    height: 20.r,
                    width: 20.r,
                  ),
                )
        ],
      ),
    );
  }
}
