import 'package:card_swiper/card_swiper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realtor_pass/features/main/core/entity/house_entity.dart';
import 'package:realtor_pass/features/main/presentation/screens/house_detail_screen.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../app_core/utils/number_helper.dart';
import '../../../../resources/resources.dart';

class HouseWidget extends StatefulWidget {
  final HouseEntity houses;

  final bool isHorizontalViewWidget;
  const HouseWidget(
      {super.key, required this.houses, this.isHorizontalViewWidget = false});

  @override
  State<HouseWidget> createState() => _HouseWidgetState();
}

class _HouseWidgetState extends State<HouseWidget>
    with AutomaticKeepAliveClientMixin {
  late bool isFavorite;

  @override
  void initState() {
    isFavorite = false;
    initialize();
    super.initState();
  }

  initialize() {}

  late List<HouseEntity> houses;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final houses = widget.houses;
    return GestureDetector(
      onTap: () => AnimatedNavigation.push(
          context: context,
          page: HouseDetailScreen(
            entity: houses,
          )),
      child: _item(context),
    );
  }

  _item(BuildContext context) {
    return widget.isHorizontalViewWidget
        ? Container(
            height: 182.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xffA1A1A1),
                width: 1,
              ),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Container(
                  width: 180.w,
                  height: 182.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: const Border(
                      right: BorderSide(
                        color: Color(0xffA1A1A1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        Swiper(
                          pagination: SwiperCustomPagination(builder:
                              (BuildContext context,
                                  SwiperPluginConfig config) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 13.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ...List.generate(
                                        config.itemCount,
                                        (index) => Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Container(
                                              // width: 24.w,
                                              height: 2.h,
                                              color: config.activeIndex == index
                                                  ? const Color(0xff474747)
                                                  : const Color(0xffC6C6C6),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 17.h),
                              ],
                            );
                          }),
                          itemCount: widget.houses.images.length,
                          itemBuilder: (context, index) => Image.asset(
                            widget.houses.images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                        _favoriteButton(),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        widget.houses.houseTitle,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff474747),
                        ),
                      ),
                      Text(
                        widget.houses.houseType,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.black,
                        ),
                      ),
                      Column(
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(Svgs.tSquare),
                              SizedBox(
                                width: 4.w,
                              ),
                              Text(
                                widget.houses.square.toString(),
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(Svgs.tRooms),
                              SizedBox(
                                width: 4.w,
                              ),
                              Text(
                                widget.houses.rooms.toString(),
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              SvgPicture.asset(Svgs.tRestroom),
                              SizedBox(
                                width: 4.w,
                              ),
                              Text(
                                widget.houses.bathroom.toString(),
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),

                      const Spacer(),

                      // ignore: prefer_interpolation_to_compose_strings
                      Text(NumberHelper.format(widget.houses.price) +
                          '\$' +
                          "/" +
                          "perMonth".tr()),
                      SizedBox(height: 6.h),
                      GestureDetector(
                        onTap: () {
                          // TODO: Form
                          // AnimatedNavigation.push(
                          //   context: context,
                          //   page: FormScreen(
                          //     carId: widget.car.id,
                          //   ),
                          // );
                        },
                        child: Container(
                          width: 143.w,
                          height: 25.h,
                          decoration: BoxDecoration(
                            color: const Color(0xff474747),
                            borderRadius: BorderRadius.circular(78.r),
                          ),
                          child: Center(
                            child: Text(
                              "rent".tr(),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 10.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 10.w),
              ],
            ),
          )
        : Container(
            height: 182.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: const Color(0xffA1A1A1),
                width: 1,
              ),
              color: Colors.white,
            ),
            child: Row(
              children: [
                Container(
                  width: 180.w,
                  height: 182.h,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    border: const Border(
                      right: BorderSide(
                        color: Color(0xffA1A1A1),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Center(
                    child: Stack(
                      children: [
                        Swiper(
                          pagination: SwiperCustomPagination(builder:
                              (BuildContext context,
                                  SwiperPluginConfig config) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 13.w),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      ...List.generate(
                                        config.itemCount,
                                        (index) => Expanded(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                right: 10),
                                            child: Container(
                                              // width: 24.w,
                                              height: 2.h,
                                              color: config.activeIndex == index
                                                  ? const Color(0xff474747)
                                                  : const Color(0xffC6C6C6),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 17.h),
                              ],
                            );
                          }),
                          itemCount: widget.houses.images.length,
                          itemBuilder: (context, index) => Image.network(
                            widget.houses.images[index],
                            fit: BoxFit.cover,
                          ),
                        ),
                        _favoriteButton(),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 10.w),
                Flexible(
                  child: Padding(
                    padding: EdgeInsets.only(bottom: 10.h, top: 13.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        FittedBox(
                          child: Text(
                            "${widget.houses.houseType} ${widget.houses.houseType}",
                            style: TextStyle(
                              fontSize: 12.sp,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xff474747),
                            ),
                          ),
                        ),
                        SizedBox(height: 3.h),
                        Text(
                          widget.houses.category,
                          style: TextStyle(
                            fontSize: 10.sp,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 9.h),
                        Row(
                          children: [
                            SvgPicture.asset(Svgs.tSquare),
                            SizedBox(width: 4.w),
                            FittedBox(
                                child: Text(
                              widget.houses.square.toString(),
                              style: TextStyle(
                                fontSize: 10.sp,
                              ),
                            )),
                          ],
                        ),
                        SizedBox(height: 9.h),
                        Row(
                          children: [
                            SvgPicture.asset(Svgs.tRooms),
                            SizedBox(width: 4.w),
                            FittedBox(
                                child: Text(
                              widget.houses.rooms.toString(),
                              style: TextStyle(
                                fontSize: 10.sp,
                              ),
                            )),
                          ],
                        ),
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            SvgPicture.asset(Svgs.tRestroom),
                            SizedBox(width: 4.w),
                            FittedBox(
                              child: Text(
                                widget.houses.bathroom.toString(),
                                style: TextStyle(
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const Spacer(),
                        // ignore: prefer_interpolation_to_compose_strings
                        Text(NumberHelper.format(widget.houses.price) +
                            '\$' +
                            "/" +
                            "perMonth".tr()),
                        SizedBox(height: 6.h),
                        GestureDetector(
                          onTap: () {
                            // AnimatedNavigation.push(
                            //   context: context,
                            //   page: FormScreen(
                            //     carId: widget.car.id,
                            //   ),
                            // );
                          },
                          child: Container(
                            height: 25.h,
                            margin: EdgeInsets.only(right: 10.w),
                            decoration: BoxDecoration(
                              color: AppStyle.blue,
                              gradient: const LinearGradient(
                                colors: [AppStyle.blue, AppStyle.darkBlue],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(78.r),
                            ),
                            child: Center(
                              child: Text(
                                "rent".tr(),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10.sp,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
  }

  _favoriteButton() {
    return IconButton(
      onPressed: () {},
      icon: Icon(
        isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
        color: isFavorite ? Colors.red : Colors.white,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
