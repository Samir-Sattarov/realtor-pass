import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../app_core/utils/app_style.dart';
import '../../../../resources/resources.dart';
import '../../core/entity/house_entity.dart';
import '../cubit/houses/houses_cubit.dart';
import '../widgets/search_widget.dart';

class LocationResultScreen extends StatefulWidget {
  const LocationResultScreen({super.key});

  @override
  State<LocationResultScreen> createState() => _LocationResultScreenState();
}

class _LocationResultScreenState extends State<LocationResultScreen> {
  final TextEditingController controllerSearch = TextEditingController();
  late List<HouseEntity> houses;

  Future<List<HouseEntity>> suggestionsCallback(String pattern) async =>
      Future<List<HouseEntity>>.delayed(
        const Duration(milliseconds: 0),
        () => houses.where((house) {
          final nameLower = house.houseType.toLowerCase().replaceAll(' ', '');
          final patternLower = pattern.toLowerCase().replaceAll(' ', '');
          return nameLower.contains(patternLower);
        }).toList(),
      );

  // void _sort(int sort) {
  //   if (sort == 0) return;
  //
  //   if (sort == 1) {
  //     houses.sort((a, b) => a.price.compareTo(b.price));
  //   } else if (sort == 2) {
  //     houses.sort((a, b) => b.price.compareTo(a.price));
  //   }
  // }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            children: [
              _buildLocationHeader(),
              SizedBox(
                height: 20.h,
              ),
              _buildSearchRow(),
              SizedBox(
                height: 18.h,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffF2F2F2),
                        borderRadius: BorderRadius.all(Radius.circular(6.r))),
                    width: 42.w,
                    height: 42.w,
                    child: Center(
                      child: SvgPicture.asset(Svgs.tLocation),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    "Нью-йорк, США",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppStyle.dark),
                  )
                ],
              ),
              SizedBox(
                height: 12.h,
              ),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: const Color(0xffF2F2F2),
                        borderRadius: BorderRadius.all(Radius.circular(6.r))),
                    width: 42.w,
                    height: 42.w,
                    child: Center(
                      child: SvgPicture.asset(Svgs.tLocation),
                    ),
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  Text(
                    "Ташкент, Узбекистан",
                    style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                        color: AppStyle.dark),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    ));
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
              BlocProvider.of<HousesCubit>(context).load(locale: context.locale.languageCode,search: value);
            },
            onFilter: (){

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
