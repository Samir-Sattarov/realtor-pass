import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../features/main/core/entity/chip_entity.dart';
import '../../../features/main/core/entity/config_entity.dart';
import '../../../features/main/presentation/cubit/config/config_cubit.dart';
import '../../../features/main/presentation/cubit/house_type/house_type_cubit.dart';
import '../../../features/main/presentation/cubit/houses/houses_cubit.dart';
import '../../../features/main/presentation/widgets/custom_chip_widget.dart';
import '../../app_core_library.dart';
import '../../widgets/button_widget.dart';
import '../test_dates.dart';

class FilterBody extends StatefulWidget {
  final Function(
    int category,
    int sort,
    int mileage,
    int consumption,
    int acceleration,
    int fromYear,
    int toYear,
    int maxPrice,
    int minPrice,
  ) onConfirm;
  final int category;
  const FilterBody({
    super.key,
    required this.category,
    required this.onConfirm,
  });

  @override
  State<FilterBody> createState() => _FilterBodyState();
}

class _FilterBodyState extends State<FilterBody> {
  final TextEditingController controllerSquareFrom = TextEditingController();
  final TextEditingController controllerSquareTo = TextEditingController();
  final TextEditingController controllerPriceFrom = TextEditingController();
  final TextEditingController controllerPriceTo = TextEditingController();
  final TextEditingController controllerFloorsTo = TextEditingController();
  final TextEditingController controllerFloorFrom = TextEditingController();

  int selectedHouseCategory = 0;
  int selectedSortCategory = 0;
  int selectedRooms = 100;
  int selectedBathRooms = 0 ;
  int selectedSeller = 0;
  int selectedWindows = 0;
  int selectedRepair = 0;
  int selectedHousingType = 0;
  int maxRooms = 100;
  int minRooms = 0;
  int maxPrice = 1000;
  int minPrice = 0;
  int maxSquare = 1000;
  int minSquare = 0;
  int maxFloors = 1000;


  List<int> roomsList = [];

  List<int> repairList = [];

  List<int> windowsList = [];

  @override
  void initState() {
    selectedHouseCategory = widget.category;
    selectedRooms = widget.category;
    selectedRepair = widget.category;
    selectedSortCategory = widget.category;
    selectedWindows = widget.category;
    super.initState();
  }

  initialize(ConfigEntity config) {
    maxRooms = config.roomsMax;
    minRooms = config.roomsMin;
    maxPrice = config.priceMax;
    minPrice = config.priceMin;
    maxSquare = config.squareMax;
    minSquare = config.squareMin;
    maxFloors = config.floorsMax;

    for (var i = config.squareMin; i <= minSquare; i += 100) {
      repairList.add(i);
    }

    for (var i = config.squareMax; i <= maxSquare; i++) {
      roomsList.add(i);
    }
    for (var i = config.floorsMax; i <= maxFloors; i++) {
      windowsList.add(i);
    }
  }

  generateData(int min, int max, List listData) {
    for (var i = min; i <= max; i++) {
      listData.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigCubit, ConfigState>(
      builder: (context, state) {
        if (state is ConfigLoaded) {
          initialize(state.entity);
        }
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Container(
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 24.h),
                    Row(
                      children: [
                        SizedBox(
                          width: 36.w,
                        ),
                        const Spacer(),
                        SizedBox(
                          width: 24.r,
                          height: 24.r,
                        ),
                        Text(
                          "filter".tr(),
                          style: TextStyle(
                            color: const Color(0xff1A1E25),
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Spacer(),
                        GestureDetector(
                          onTap: () => Navigator.pop(context),
                          child: SizedBox(
                            width: 24.r,
                            height: 24.r,
                            child: const Center(
                                child: Icon(Icons.close,
                                    color: Color(0xff0F172A))),
                          ),
                        ),
                        SizedBox(
                          width: 36.w,
                        ),
                      ],
                    ),
                    SizedBox(height: 21.h),
                    Container(
                      height: 0.6.h,
                      color: const Color(0xffA1A1A1),
                    ),
                    SizedBox(height: 12.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "price".tr(),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: AppStyle.blue,
                                ),
                              ),
                              TextButton(
                                onPressed: () {},
                                child: Text(
                                  "reset".tr(),
                                  style: TextStyle(
                                      color: AppStyle.blue,
                                      fontSize: 10.sp,
                                      fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 12.h),
                          SizedBox(
                            height: 49.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Flexible(
                                  flex: 5,
                                  child: TextFormField(
                                    controller: controllerPriceFrom,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 19.w, right: 8.w),
                                      hintText: "${"from".tr()} $minPrice",
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppStyle.blue,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(50.r)),
                                        borderSide: const BorderSide(
                                          color: Color(0xffA1A1A1),
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xffA1A1A1),
                                          width: 1,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xffA1A1A1),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  flex: 5,
                                  child: TextFormField(
                                    controller: controllerPriceTo,
                                    keyboardType: TextInputType.phone,
                                    decoration: InputDecoration(
                                      hintText: "${"to".tr()} $maxSquare",
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppStyle.blue,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: 19.w, right: 8.w),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.horizontal(
                                            left: Radius.circular(11.r)),
                                        borderSide: const BorderSide(
                                          color: Color(0xffA1A1A1),
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xffA1A1A1),
                                          width: 1,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xffA1A1A1),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      color: const Color(0xffDADADA),
                      height: 5.h,
                      width: MediaQuery.of(context).size.width,
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.h),
                      child: Text(
                        "numberOfRooms",
                        style: TextStyle(
                            color: AppStyle.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    SizedBox(
                      height: 30.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 8.w),
                        itemBuilder: (context, index) {
                          final entity = TestDates.sorting[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedRooms = entity.id;
                              });
                            },
                            child: CustomChipWidget(
                              entity: entity,
                              currentIndex: selectedRooms,
                            ),
                          );
                        },
                        itemCount: TestDates.sorting.length,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    SizedBox(height: 12.h),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "square".tr(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppStyle.blue,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          SizedBox(
                            height: 36.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: controllerSquareFrom,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FieldMasks.yearMarks,
                                    ],
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 19.w, right: 8.w),
                                      hintText: "${"from".tr()} $minSquare",
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppStyle.blue,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xffA1A1A1),
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xffA1A1A1),
                                          width: 1,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xffA1A1A1),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: controllerSquareTo,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: [
                                      FieldMasks.yearMarks,
                                    ],
                                    decoration: InputDecoration(
                                      hintText: "${"to".tr()} $maxSquare",
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppStyle.blue,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: 19.w, right: 8.w),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xffA1A1A1),
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xffA1A1A1),
                                          width: 1,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xffA1A1A1),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.h),
                      child: Text(
                        "houseCategory",
                        style: TextStyle(
                            color: AppStyle.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    SizedBox(
                      height: 30.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 8.w),
                        itemBuilder: (context, index) {
                          final entity = TestDates.sorting[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSortCategory = entity.id;
                              });
                            },
                            child: CustomChipWidget(
                              entity: entity,
                              currentIndex: selectedSortCategory,
                            ),
                          );
                        },
                        itemCount: TestDates.sorting.length,
                      ),
                    ),
                    SizedBox(height: 28.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.h),
                      child: Text(
                        "seller",
                        style: TextStyle(
                            color: AppStyle.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    SizedBox(
                      height: 30.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 8.w),
                        itemBuilder: (context, index) {
                          final entity = TestDates.sorting[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSeller = entity.id;
                              });
                            },
                            child: CustomChipWidget(
                              entity: entity,
                              currentIndex: selectedSeller,
                            ),
                          );
                        },
                        itemCount: TestDates.sorting.length,
                      ),
                    ),
                    SizedBox(height: 28.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.h),
                      child: Text(
                        "repair",
                        style: TextStyle(
                            color: AppStyle.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    SizedBox(
                      height: 30.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 8.w),
                        itemBuilder: (context, index) {
                          final entity = TestDates.sorting[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedRepair = entity.id;
                              });
                            },
                            child: CustomChipWidget(
                              entity: entity,
                              currentIndex: selectedRepair,
                            ),
                          );
                        },
                        itemCount: TestDates.sorting.length,
                      ),
                    ),
                    SizedBox(height: 28.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.h),
                      child: Text(
                        "bathroom",
                        style: TextStyle(
                            color: AppStyle.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    SizedBox(
                      height: 30.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 8.w),
                        itemBuilder: (context, index) {
                          final entity = TestDates.sorting[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedBathRooms = entity.id;
                              });
                            },
                            child: CustomChipWidget(
                              entity: entity,
                              currentIndex: selectedBathRooms,
                            ),
                          );
                        },
                        itemCount: TestDates.sorting.length,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "floors".tr(),
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                              color: AppStyle.blue,
                            ),
                          ),
                          SizedBox(height: 12.h),
                          SizedBox(
                            height: 30.h,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: controllerFloorFrom,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      contentPadding: EdgeInsets.only(
                                          left: 19.w, right: 8.w),
                                      hintText: "${"from".tr()} $minSquare",
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppStyle.blue,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xffA1A1A1),
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xffA1A1A1),
                                          width: 1,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xffA1A1A1),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: TextFormField(
                                    controller: controllerFloorsTo,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                      hintText: "${"to".tr()} $maxSquare",
                                      hintStyle: TextStyle(
                                        fontSize: 14.sp,
                                        color: AppStyle.blue,
                                      ),
                                      contentPadding: EdgeInsets.only(
                                          left: 19.w, right: 8.w),
                                      border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xffA1A1A1),
                                          width: 1,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xffA1A1A1),
                                          width: 1,
                                        ),
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        borderSide: const BorderSide(
                                          color: Color(0xffA1A1A1),
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.h),
                      child: Text(
                        "houseType",
                        style: TextStyle(
                            color: AppStyle.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    SizedBox(
                      height: 30.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 8.w),
                        itemBuilder: (context, index) {
                          final entity = TestDates.sorting[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedHousingType = entity.id;
                              });
                            },
                            child: CustomChipWidget(
                              entity: entity,
                              currentIndex: selectedHousingType,
                            ),
                          );
                        },
                        itemCount: TestDates.sorting.length,
                      ),
                    ),
                    SizedBox(height: 28.h,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.h),
                      child: Text(
                        "windows",
                        style: TextStyle(
                            color: AppStyle.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),

                    SizedBox(
                      height: 30.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 22.w),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 8.w),
                        itemBuilder: (context, index) {
                          final entity = TestDates.sorting[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedWindows = entity.id;
                              });
                            },
                            child: CustomChipWidget(
                              entity: entity,
                              currentIndex: selectedWindows,
                            ),
                          );
                        },
                        itemCount: TestDates.sorting.length,
                      ),
                    ),
                    SizedBox(height: 28.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.w),
                      child: Row(
                        children: [
                          Expanded(
                            child: ButtonWidget(
                              title: "confirm".tr(),
                              onTap: () {
                                maxRooms =
                                    int.tryParse(controllerSquareFrom.text) ??
                                        maxRooms;
                                minRooms =
                                    int.tryParse(controllerSquareTo.text) ??
                                        minRooms;

                                widget.onConfirm.call(
                                  selectedHouseCategory,
                                  selectedSortCategory,
                                  selectedRooms,
                                  selectedWindows,
                                  selectedRepair,
                                  maxRooms,
                                  minRooms,
                                  maxPrice,
                                  minPrice,
                                );
                              },
                              color: const Color(0xff474747),
                            ),
                          ),
                          SizedBox(
                            width: 10.w,
                          ),
                          Expanded(
                            child: ButtonWidget(
                              title: "reset".tr(),
                              customWidget: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.refresh,
                                    color: AppStyle.backgroundWhite,
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    "reset".tr(),
                                    style: TextStyle(
                                        color: AppStyle.backgroundWhite,
                                        fontSize: 14.sp,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              color: Colors.transparent,
                              onTap: () {
                                BlocProvider.of<HousesCubit>(context).load();
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 35.h),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
