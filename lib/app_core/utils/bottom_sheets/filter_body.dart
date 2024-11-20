import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../features/main/core/entity/chip_entity.dart';
import '../../../features/main/core/entity/config_entity.dart';
import '../../../features/main/presentation/cubit/config/config_cubit.dart';
import '../../../features/main/presentation/cubit/house_selling_type/house_selling_type_cubit.dart';
import '../../../features/main/presentation/cubit/house_type/house_type_cubit.dart';
import '../../../features/main/presentation/cubit/houses/houses_cubit.dart';
import '../../../features/main/presentation/widgets/custom_chip_widget.dart';
import '../../app_core_library.dart';
import '../../widgets/button_widget.dart';

class FilterBody extends StatefulWidget {
  final Function(
    int houseType,
    int bedrooms,
    int beds,
    int maxPrice,
    int minPrice,
  ) onConfirm;
  final int houseType;
  const FilterBody({
    super.key,
    required this.houseType,
    required this.onConfirm,
  });

  @override
  State<FilterBody> createState() => _FilterBodyState();
}

class _FilterBodyState extends State<FilterBody> {
  final TextEditingController controllerPriceFrom = TextEditingController();
  final TextEditingController controllerPriceTo = TextEditingController();

  int selectedBeds = 0;
  int selectedBedRooms = 0;
  int selectedSellType = 0;
  int selectedHousingType = 0;
  int maxPrice = 0;
  int minPrice = 0;


  @override
  void initState() {
    selectedBeds = widget.houseType;
    super.initState();
  }

  initialize(ConfigEntity config) {
    maxPrice = config.priceMax;
    minPrice = config.priceMin;
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
                                      hintText: "${"to".tr()} $maxPrice",
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
                    SizedBox(height: 28.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.h),
                      child: Text(
                        "houseType".tr(),
                        style: TextStyle(
                            color: AppStyle.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
                    BlocBuilder<HouseTypeCubit, HouseTypeState>(
                      builder: (context, state) {
                        if (state is HouseTypeLoaded) {
                          final categories = state.results.housesType;
                          return SizedBox(
                            height: 30.h,
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 22.w),
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 8.w),
                              itemBuilder: (context, index) {
                                final category = categories[index];
                                final ChipEntity chip = ChipEntity(
                                  id: category.id,
                                  title: category.title,
                                  image: '',
                                );
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedHousingType = chip.id;
                                    });
                                  },
                                  child: CustomChipWidget(
                                    entity: chip,
                                    currentIndex: selectedHousingType,
                                  ),
                                );
                              },
                              itemCount: categories.length,
                            ),
                          );
                        }
                        return SizedBox();
                      },
                    ),
                    SizedBox(height: 16.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 22.h),
                      child: Text(
                        "sellingType".tr(),
                        style: TextStyle(
                            color: AppStyle.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 14.sp),
                      ),
                    ),
                    SizedBox(
                      height: 12.h,
                    ),
                    BlocBuilder<HouseSellingTypeCubit, HouseSellingTypeState>(
                      builder: (context, state) {
                        if (state is HouseSellingTypeLoaded) {
                          final sellingType =
                              state.resultEntity.houseSellingType;
                          return SizedBox(
                            height: 30.h,
                            child: ListView.separated(
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              padding: EdgeInsets.symmetric(horizontal: 22.w),
                              scrollDirection: Axis.horizontal,
                              separatorBuilder: (context, index) =>
                                  SizedBox(width: 8.w),
                              itemBuilder: (context, index) {
                                final sellingTypes = sellingType[index];
                                final ChipEntity chip = ChipEntity(
                                  id: sellingTypes.id,
                                  title: sellingTypes.title,
                                  image: '',
                                );
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedSellType = sellingTypes.id;
                                    });
                                  },
                                  child: CustomChipWidget(
                                    entity: chip,
                                    currentIndex: selectedSellType,
                                  ),
                                );
                              },
                              itemCount: sellingType.length,
                            ),
                          );
                        }
                        return const SizedBox();
                      },
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Minimum Bedrooms
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 22.h),
                            child: Text(
                              "MinimumBedRooms".tr(),
                              style: TextStyle(
                                color: AppStyle.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (selectedBedRooms > 1) selectedBedRooms--;
                                    });
                                  },
                                  icon: Icon(Icons.remove, color: AppStyle.blue),
                                ),
                                Text(
                                  "$selectedBedRooms",
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    setState(() {
                                      if (selectedBedRooms < 10) selectedBedRooms++;
                                    });
                                  },
                                  icon: Icon(Icons.add, color: AppStyle.blue),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      // Minimum Beds
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 22.h),
                            child: Text(
                              "MinimumBeds".tr(),
                              style: TextStyle(
                                color: AppStyle.blue,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (selectedBeds > 1) selectedBeds--;
                                  });
                                },
                                icon: Icon(Icons.remove, color: AppStyle.blue),
                              ),
                              Text(
                                "$selectedBeds",
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  setState(() {
                                    if (selectedBeds < 10) selectedBeds++;
                                  });
                                },
                                icon: Icon(Icons.add, color: AppStyle.blue),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
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
                                maxPrice =
                                    int.tryParse(controllerPriceFrom.text) ??
                                        maxPrice;
                                minPrice =
                                    int.tryParse(controllerPriceTo.text) ??
                                        minPrice;

                                widget.onConfirm.call(
                                  selectedHousingType,
                                  maxPrice,
                                  minPrice,
                                  selectedBeds,
                                  selectedBedRooms
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
                                BlocProvider.of<HousesCubit>(context)
                                    .load(locale: context.locale.languageCode);
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
