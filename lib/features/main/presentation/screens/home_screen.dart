import 'package:card_swiper/card_swiper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../../app_core/utils/app_style.dart';
import '../../../../app_core/utils/bottom_sheets/bottom_sheets.dart';
import '../../../../resources/resources.dart';
import '../../core/entity/house_entity.dart';
import '../cubit/houses/houses_cubit.dart';
import '../cubit/posters/posters_cubit.dart';
import '../cubit/questions/questions_cubit.dart';
import '../widgets/fav_conditions_widget.dart';
import '../widgets/questions_widget.dart';
import '../widgets/search_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late List<HouseEntity> houses = [];

  final TextEditingController controllerSearch = TextEditingController();
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
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
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
              Row(
                children: [
                  Expanded(
                    child: SearchWidget(
                      controller: controllerSearch,
                      onSearch: (value) {
                        BlocProvider.of<HousesCubit>(context)
                            .load(search: value);
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
              ),
              SizedBox(height: 34.h),
              BlocBuilder<PostersCubit, PostersState>(
                builder: (context, state) {
                  if (state is PostersLoaded) {
                    final images = state.posters.images;
                    return images.isEmpty
                        ? const SizedBox()
                        : Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 21.w),
                                child: AbsorbPointer(
                                  child: Container(
                                    height: 198.h,
                                    width: MediaQuery.of(context).size.width,
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                    child: Stack(
                                      children: [
                                        Center(
                                          child: SizedBox(
                                            height: MediaQuery.of(context)
                                                .size
                                                .height,
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Center(
                                              child: Swiper(
                                                autoplay: true,
                                                itemCount: images.length,
                                                itemBuilder: (context, index) {
                                                  final image = images[index];
                                                  return Image.network(
                                                    image,
                                                    fit: BoxFit.cover,
                                                  );
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.all(16.r),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Text(
                                                "homeScreenPosterText".tr(),
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 16.sp,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(height: 18.h),
                            ],
                          );
                  }
                  return const SizedBox();
                },
              ),
              SizedBox(
                height: 34.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: _questionBlockWidget(
                  context,
                  title: "fewItemsBeforeRentHome".tr(),
                  onTap: () {
                    BottomSheets.fewStepsBeforeRent(context);

                  },
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 1.w),
                child: FavConditionsWidget(
                  onTap: () {
                    BottomSheets.favConditions(context, onFillForm: (){});

                  },
                ),
              ).animate().shimmer(),
              BlocBuilder<QuestionsCubit, QuestionsState>(
                builder: (context, state) {
                  if (state is QuestionsLoaded) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 21.w),
                      child: QuestionsWidget(
                        questions: state.data.questions,
                      ),
                    );
                  }

                  return const SizedBox();
                },
              ),
            ],
          ),
        ),
      )),
    );
  }

  _questionBlockWidget(
    BuildContext context, {
    required String title,
    required Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 65.h,
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xff001E21).withOpacity(0.2),
              blurRadius: 21,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            FittedBox(
              child: Text(
                title,
                style: TextStyle(
                  color: AppStyle.blue,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
            ),
            const Icon(
              Icons.chevron_right,
              color: Color(0xff474747),
            ),
          ],
        ),
      ).animate().shimmer(),
    );
  }
}
