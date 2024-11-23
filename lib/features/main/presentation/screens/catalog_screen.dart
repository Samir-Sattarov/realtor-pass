import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../app_core/utils/app_style.dart';
import '../../../../app_core/utils/bottom_sheets/bottom_sheets.dart';
import '../../../../app_core/widgets/error_flash_bar.dart';
import '../../../../resources/resources.dart';
import '../../core/entity/chip_entity.dart';
import '../../core/entity/house_entity.dart';
import '../../core/entity/house_type_entity.dart';
import '../cubit/house_type/house_type_cubit.dart';
import '../cubit/houses/houses_cubit.dart';
import '../widgets/custom_chip_widget.dart';
import '../widgets/google_map_widget.dart';
import '../widgets/house_widget.dart';
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
  late List<HouseTypeEntity> houseType;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() async {
    scrollController = ScrollController();
    houses = [];
    houseType = [];

    await EasyLocalization.ensureInitialized().then((value) {
      BlocProvider.of<HousesCubit>(context)
          .load(locale: context.locale.languageCode.toString());
    });
    await EasyLocalization.ensureInitialized().then((value) {
      BlocProvider.of<HouseTypeCubit>(context)
          .load(locale: context.locale.languageCode.toString());
    });

    scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (scrollController.position.pixels ==
        scrollController.position.maxScrollExtent) {
      Future.delayed(
        const Duration(milliseconds: 200),
        () {
          BlocProvider.of<HousesCubit>(context)
              .loadMore(locale: context.locale.languageCode);
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
          final nameLower =
              house.houseLocation.toLowerCase().replaceAll(' ', '');
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
                BlocListener<HouseTypeCubit, HouseTypeState>(
                  listener: (context, state) {
                    if (state is HouseTypeError) {
                      ErrorFlushBar(state.message).show(context);
                    }
                    if (state is HouseTypeLoaded) {
                      if (mounted) {
                        Future.delayed(
                          Duration.zero,
                          () {
                            houseType = state.results.housesType;

                            print("House type $houseType");
                            setState(() {});
                          },
                        );
                      }
                    }
                  },
                  child: SizedBox(
                    height: 27.h,
                    width: 1.sw,
                    child: ListView.separated(
                      shrinkWrap: true,
                      physics: const ClampingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      separatorBuilder: (context, index) =>
                          SizedBox(width: 8.w),
                      itemBuilder: (context, index) {
                        final entity = houseType[index];
                        final ChipEntity chip = ChipEntity(
                            id: entity.id,
                            title: entity.title,
                            image: entity.image);

                        return GestureDetector(
                          onTap: () {
                            if (selectedHouseCategory == entity.id) {
                              setState(() {
                                selectedHouseCategory = 0;
                              });

                              BlocProvider.of<HousesCubit>(context)
                                  .load(locale: context.locale.languageCode);
                            } else {
                              setState(() {
                                selectedHouseCategory = entity.id;
                              });

                              BlocProvider.of<HousesCubit>(context).load(
                                locale: context.locale.languageCode.toString(),
                                houseType: selectedHouseCategory,
                              );
                            }
                          },
                          child: CustomChipWidget(
                            entity: chip,
                            currentIndex: selectedHouseCategory,
                          ),
                        );
                      },
                      itemCount: houseType.length,
                    ),
                  ),
                ),
                SizedBox(
                  height: 16.h,
                ),
                ClipRRect(
                  borderRadius:  BorderRadius.horizontal(
                right: Radius.circular(10.r), left: Radius.circular(10.r)),
                  child: SizedBox(width: 340.w,height: 200.h,
                      child: GoogleMapWidget()),
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
                              child: HouseWidget(
                                houses: house,
                              ),
                            );
                          })
                        ],
                      ),
                    );
                  },
                ),
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
              BlocProvider.of<HousesCubit>(context).load(
                  search: value,
                  locale: context.locale.languageCode.toString());
            },
            onFilter: () {
              BottomSheets.filter(
                context,
                category: selectedHouseCategory,
                onConfirm: (
                  int houseType,
                  int bedrooms,
                  int beds,
                  int maxPrice,
                  int minPrice,
                ) {
                  BlocProvider.of<HousesCubit>(context).load(
                      search: controllerSearch.text,
                      sellingType: houseType,
                      houseType: houseType,
                      rooms: beds,
                      bathroom: bedrooms,
                      maxPrice: maxPrice,
                      minPrice: minPrice,
                      locale: context.locale.languageCode.toString());
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
