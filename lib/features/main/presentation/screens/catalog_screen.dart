import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realtor_pass/app_core/app_core_library.dart';
import 'package:realtor_pass/app_core/utils/app_style.dart';
import 'package:realtor_pass/app_core/widgets/error_flash_bar.dart';
import 'package:realtor_pass/features/main/presentation/cubit/house_type/house_type_cubit.dart';
import 'package:realtor_pass/features/main/presentation/cubit/houses/houses_cubit.dart';
import 'package:realtor_pass/features/main/presentation/widgets/search_widget.dart';
import '../../../../app_core/widgets/loading_widget.dart';
import '../../../../resources/resources.dart';
import '../../core/entity/house_entity.dart';
import '../widgets/house_vertical_view_widget.dart';
import '../widgets/map_widget.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  final TextEditingController controllerSearch = TextEditingController();
  late ScrollController scrollController;
  int selectedCarCategory = 0;
  late List<HouseEntity> houses;

  @override
  void initState() {
    initialize();
    super.initState();
  }

  initialize() {
    scrollController = ScrollController();
    houses = [
      HouseEntity(
          id: -1,
          houseTitle: "Hello",
          houseLocation: "20.0,10.4",
          isFavorite: false,
          houseType: "",
          category: "",
          categoryId: -1,
          description: "",
          images: [],
          price: 10,
          square: 10,
          bathroom: 1,
          rooms: 1,
          lon: 10,
          lat: 10),
      HouseEntity(
          houseTitle: "Hello",
          id: -1,
          houseLocation: "40.0,60.4",
          isFavorite: false,
          houseType: "",
          category: "",
          categoryId: -1,
          description: "",
          images: [],
          price: 10,
          square: 10,
          bathroom: 1,
          rooms: 1,
          lon: 10,
          lat: 10),
      HouseEntity(
          houseTitle: "Hello",
          id: -1,
          houseLocation: "64.0,50.4",
          isFavorite: false,
          houseType: "",
          category: "",
          categoryId: -1,
          description: "",
          images: [],
          price: 10,
          square: 10,
          bathroom: 1,
          rooms: 1,
          lon: 10,
          lat: 10),
    ];
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
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildLocationHeader(),
              SizedBox(height: 20.h),
              _buildSearchRow(),
              SizedBox(height: 20.h),
              MapWidget(
                houses: houses,
              ),
              BlocBuilder<HouseTypeCubit, HouseTypeState>(
                builder: (context, state) {
                  if (state is HouseTypeLoaded) {
                    final categories = state.results.houses;
                    return SizedBox(
                      height: 26.h,
                      child: ListView.separated(
                        shrinkWrap: true,
                        physics: const ClampingScrollPhysics(),
                        padding: EdgeInsets.symmetric(horizontal: 21.w),
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 8.w),
                        itemBuilder: (context, index) {
                          final category = categories[index];

                          // final ChipEntity chip = ChipEntity(
                          //   id: category.id,
                          //   title: category.title,
                          // );
                          return GestureDetector(
                            onTap: () {
                              if (selectedCarCategory == category.id) {
                                setState(() {
                                  selectedCarCategory = 0;
                                });

                                BlocProvider.of<HousesCubit>(context).load();
                              } else {
                                setState(() {
                                  selectedCarCategory = category.id;
                                });

                                BlocProvider.of<HousesCubit>(context).load(
                                  category: selectedCarCategory,
                                );
                              }
                            },
                            // child: CustomChipWidget(
                            //   entity: chip,
                            //   currentIndex: selectedCarCategory,
                            // ),
                          );
                        },
                        itemCount: categories.length,
                      ),
                    );
                  }
                  return const SizedBox();
                },
              ),
              BlocConsumer<HousesCubit, HousesState>(
                listener: (context, state) {
                  if (state is HousesError) {
                    ErrorFlushBar(state.message).show(context);
                  }
                },
                builder: (context, state) {
                  if (state is HousesLoaded) {
                    houses = state.houses;
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      child: Column(
                        children: [
                          Container(
                            height: 100.h,
                            width: 1.sw,
                            color: Colors.grey,
                          ),
                          Expanded(
                            child: HouseVerticalWidget(
                              houses: houses,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Center(child: LoadingWidget());
                  }
                },
              ),
            ],
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
            onFilter: () {},
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
