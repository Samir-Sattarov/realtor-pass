import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realtor_pass/app_core/utils/number_helper.dart';
import '../../../../app_core/utils/app_style.dart';
import '../../../../app_core/widgets/back_widget.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../../../../app_core/widgets/error_flash_bar.dart';
import '../../../../resources/resources.dart';
import '../../core/entity/house_entity.dart';
import '../../core/entity/house_stuff_entity.dart';
import '../cubit/favorite/favorite_cubit.dart';
import '../cubit/house_stuff/house_stuff_cubit.dart';
import '../widgets/favorite_button_widget.dart';
import '../widgets/house_stuff_widget.dart';

class HouseDetailScreen extends StatefulWidget {
  final HouseEntity entity;

  const HouseDetailScreen({
    super.key,
    required this.entity,
  });

  @override
  State<HouseDetailScreen> createState() => _HouseDetailScreenState();
}

class _HouseDetailScreenState extends State<HouseDetailScreen> {
  late bool isFavorite;
  late int currentImageIndex;
  late List<HouseStuffEntity> houseStuff;

  @override
  void initState() {
    super.initState();
    currentImageIndex = 0;
    houseStuff = [];
    final favoriteCubit = BlocProvider.of<FavoriteHousesCubit>(context);
    isFavorite = favoriteCubit.isFavorite(widget.entity.id);
    initialize();
  }

  initialize() async {
    await EasyLocalization.ensureInitialized().then((value) {
      BlocProvider.of<HouseStuffCubit>(context)
          .load(locale: context.locale.languageCode);
    });
  }

  @override
  Widget build(BuildContext context) {
    final entity = widget.entity;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildImageSwiper(entity),
              SizedBox(height: 20.h),
              buildHouseTitle(entity),
              buildFeatureCards(entity),
              SizedBox(height: 20.h),
              buildDescription(entity),
              SizedBox(height: 20.h),
              buildHouseStuffList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: buildBottomBar(entity),
    );
  }

  Widget buildImageSwiper(HouseEntity entity) {
    return SizedBox(
      height: 228.h,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          Swiper(
            itemCount: entity.images.length,
            onIndexChanged: (value) {
              setState(() {
                currentImageIndex = value;
              });
            },
            pagination: SwiperPagination(
              builder: DotSwiperPaginationBuilder(
                size: 8.0,
                activeSize: 10.0,
                activeColor: Colors.white,
                color: Colors.grey.shade400,
              ),
            ),
            itemBuilder: (context, index) {
              return Stack(
                fit: StackFit.expand,
                children: [
                  ExtendedImage.network(
                    entity.images[index],
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.black54, Colors.transparent],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          Positioned(
            right: 5.w,
            top: 5.h,
            child: FavoriteButtonWidget(entity: widget.entity),
          ),
          Positioned(
            left: 5.w,
            top: 5.h,
            child: BackWidget(
              onBack: () => Navigator.pop(context),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildHouseTitle(HouseEntity entity) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
                Expanded(
                  child: Text(
                    entity.houseTitle,
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      color: AppStyle.blue,
                    ),
                  ),
                ),

            ],
          ),
          SizedBox(height: 6.h),
          Text(
            entity.category.toString(),
            style: TextStyle(
              fontSize: 16.sp,
              color: AppStyle.blue,
              fontWeight: FontWeight.w600
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            entity.houseLocation,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: 20.h,)
        ],
      ),
    );
  }

  Widget buildFeatureCards(HouseEntity entity) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          buildFeatureCard(Svgs.tRooms, "${entity.beds} ", "rooms".tr()),
          buildFeatureCard(
              Svgs.tRestroom, "${entity.bathrooms}", "bathrooms".tr()),
          buildFeatureCard(Svgs.tHome, "${entity.guests}", "guests".tr()),
        ],
      ),
    );
  }

  Widget buildFeatureCard(String svgPath, String value, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(svgPath,
            width: 24.w, height: 24.h, color: AppStyle.blue),
        SizedBox(height: 8.h),
        Text(value,
            style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold)),
        SizedBox(height: 4.h),
        Text(label,
            style: TextStyle(fontSize: 12.sp, color: Colors.grey.shade600)),
      ],
    );
  }

  Widget buildDescription(HouseEntity entity) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          entity.description,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.grey.shade800,
            height: 1.6.h,
          ),
        ),
      ),
    );
  }

  Widget buildHouseStuffList() {
    return BlocConsumer<HouseStuffCubit, HouseStuffState>(
      listener: (context, state) {
        if (state is HouseStuffError) {
          ErrorFlushBar(state.message).show(context);
        }

        if (state is HouseStuffLoaded) {
          if (mounted) {
            Future.delayed(
              Duration.zero,
              () {
                setState(() {
                  houseStuff = state.data;
                });
              },
            );
          }
        }
      },
      builder: (context, state) {
        return ListView.separated(
          padding: EdgeInsets.symmetric(vertical: 10.h),
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: houseStuff.length,
          itemBuilder: (context, index) {
            final stuff = houseStuff[index];
            return HouseStuffWidget(stuffEntity: stuff);
          },
          separatorBuilder: (BuildContext context, int index) =>
              SizedBox(height: 10.h),
        );
      },
    );
  }

  Widget buildBottomBar(HouseEntity entity) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Center(
            child: Text(
              "${NumberHelper.format(entity.price)}\$ / ${"perMonth".tr()}",
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.w600,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(height: 12.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  width: 200.w,
                  child: ButtonWidget(
                      title: "makeAnAppointment".tr(), onTap: () {})),
              TextButton(
                onPressed: () {},
                child: Text(
                  "contactARealtor".tr(),
                  style: TextStyle(
                      color: AppStyle.blue,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700),
                ),
              )
            ],
          ),
          SizedBox(
            height: 30.h,
          ),
        ],
      ),
    );
  }
}
