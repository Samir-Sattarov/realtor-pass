import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../app_core/utils/app_style.dart';
import '../../../../app_core/utils/bottom_sheets/bottom_sheets.dart';
import '../../../../app_core/utils/test_dates.dart';
import '../../../../resources/resources.dart';
import '../../core/entity/chip_entity.dart';
import '../../core/entity/house_entity.dart';
import '../cubit/house_type/house_type_cubit.dart';
import '../cubit/houses/houses_cubit.dart';
import '../widgets/custom_chip_widget.dart';
import '../widgets/house_widget.dart';
import '../widgets/map_widget.dart';
import '../widgets/search_widget.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final TextEditingController controllerSearch = TextEditingController();
  late ScrollController scrollController;
  int selectedHouseCategory = 0;
  late List<HouseEntity> houses;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() {
    scrollController = ScrollController();
    houses = TestDates.houses;
    BlocProvider.of<HousesCubit>(context).load();

    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      Future.delayed(
        const Duration(milliseconds: 200),
        () {
          BlocProvider.of<HousesCubit>(context).loadMore();
        },
      );
    }
  }

  @override
  void dispose() {
    scrollController.removeListener(_scrollListener);
    scrollController.dispose();
    super.dispose();
  }

  Future<List<HouseEntity>> suggestionsCallback(String pattern) async =>
      Future<List<HouseEntity>>.delayed(
        const Duration(milliseconds: 0),
        () => houses.where((house) {
          final nameLower = house.houseType.toLowerCase().replaceAll(' ', '');
          final patternLower = pattern.toLowerCase().replaceAll(' ', '');
          return nameLower.contains(patternLower);
        }).toList(),
      );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          controller: scrollController,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLocationHeader(),
                SizedBox(height: 20.h),
                _buildSearchRow(),
                SizedBox(height: 16.h),
                BlocBuilder<HouseTypeCubit, HouseTypeState>(
                  builder: (context, state) {
                    return SizedBox(
                      height: 30.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 8.w),
                        itemBuilder: (context, index) {
                          final entity = TestDates.sorting[index];
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedHouseCategory = entity.id;
                              });
                            },
                            child: CustomChipWidget(
                              entity: entity,
                              currentIndex: selectedHouseCategory,
                            ),
                          );
                        },
                        itemCount: TestDates.sorting.length,
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: 16.h,
                ),
                MapWidget(
                  houses: houses,
                ),
                SizedBox(
                  height: 16.h,
                ),

                BlocConsumer<HousesCubit, HousesState>(
                  listener: (context, state) {
                    if (state is HousesLoaded) {
                      if (mounted) {
                        Future.delayed(
                          Duration.zero,
                          () {
                            setState(() {
                              houses = state.houses;
                            });
                          },
                        );
                      }
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: Column(
                        children: [
                          ...List.generate(houses.length, (index) {
                            final house = houses[index];

                            return Padding(
                              padding: EdgeInsets.only(bottom: 10.h),
                              child: HouseWidget(houses: house),
                            );
                          })
                        ],
                      ),
                    );
                    // return Expanded(
                    //   child: ListView.separated(
                    //     itemBuilder: (context, index) {
                    //       final house = houses[index];
                    //
                    //       return HouseWidget(houses: house);
                    //     },
                    //     separatorBuilder: (context, index) =>
                    //         SizedBox(height: 10.h),
                    //     itemCount: houses.length,
                    //   ),
                    // );
                  },
                ),

                // BlocConsumer<HousesCubit, HousesState>(
                //   listener: (context, state) {
                //     if (state is HousesError) {
                //       ErrorFlushBar(state.message).show(context);
                //     }
                //   },
                //   builder: (context, state) {
                //     if (state is HousesLoaded) {
                //       houses = state.houses;
                //       return Padding(
                //         padding: EdgeInsets.symmetric(horizontal: 20.w),
                //         child: Column(
                //           children: [
                //             Container(
                //               height: 100.h,
                //               width: 1.sw,
                //               color: Colors.grey,
                //             ),
                //             Expanded(
                //               child: HouseVerticalWidget(
                //                 houses: houses,
                //               ),
                //             ),
                //           ],
                //         ),
                //       );
                //     } else {
                //       return const Center(child: LoadingWidget());
                //     }
                //   },
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLocationHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "yourLocation".tr(),
          style: TextStyle(
            color: AppStyle.darkGrey,
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const Icon(
              Icons.location_on_outlined,
              color: AppStyle.blue,
            ),
            SizedBox(width: 5.w),
            Text(
              "Samarkand, Uzbekistan".tr(),
              style: TextStyle(
                color: AppStyle.blue,
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(Svgs.tGeoIcon),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSearchRow() {
    return Row(
      children: [
        Expanded(
          child: SearchWidget(
            controller: controllerSearch,
            onSearch: (value) {
              BlocProvider.of<HousesCubit>(context).load(search: value);
            },
            onFilter: () {
              BottomSheets.filter(
                context,
                category: selectedHouseCategory,
                onConfirm: (
                  houseType,
                  category,
                  sort,
                  windows,
                  rooms,
                  square,
                  bathrooms,
                  location,
                  maxPrice,
                  minPrice,
                ) {
                  BlocProvider.of<HousesCubit>(context).load(
                    search: controllerSearch.text,
                    houseType: houseType,
                    category: category,
                    rooms: rooms,
                    square: square,
                    bathroom: bathrooms,
                    maxPrice: maxPrice,
                    minPrice: minPrice,
                  );
                },
              );
            },
            suggestionsCallback: suggestionsCallback,
            itemBuilder: (BuildContext context, HouseEntity house) {
              return Container(
                padding: EdgeInsets.all(8.r),
                width: MediaQuery.of(context).size.width,
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(house.houseType),
                        Text(house.houseLocation),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
