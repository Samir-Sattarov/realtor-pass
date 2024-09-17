import 'package:card_swiper/card_swiper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:realtor_pass/features/main/core/entity/house_entity.dart';
import 'package:realtor_pass/features/main/presentation/screens/house_detail_screen.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../app_core/utils/number_helper.dart';
import '../../../../resources/resources.dart';

class HouseWidget extends StatefulWidget {
  final HouseEntity houses;

  const HouseWidget({
    super.key,
    required this.houses,
  });

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
    return Container(
      height: 182.h,
      width: 1.sw,
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
                        (BuildContext context, SwiperPluginConfig config) {
                      return Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 13.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ...List.generate(
                                  config.itemCount,
                                  (index) => Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
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

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  Text(
                    widget.houses.houseTitle,
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.bold,
                      color: AppStyle.blue,
                    ),
                  ),
                  SizedBox(height: 5.h,),
                  Text(
                    widget.houses.category,
                    style: TextStyle(
                      fontSize: 10.sp,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 50.h,),

                  Text(NumberHelper.format(widget.houses.price) +
                      '\$' +
                      "/" +
                      "perMonth".tr()),
                  SizedBox(height: 6.h),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      width: 143.w,
                      height: 25.h,
                      decoration: BoxDecoration(
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
      onPressed: () {

      },
      icon: Icon(
        isFavorite ? Icons.favorite_rounded : Icons.favorite_outline_rounded,
        color: isFavorite ? Colors.red : Colors.white,
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
