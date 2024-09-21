import 'package:easy_image_viewer/easy_image_viewer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realtor_pass/app_core/app_core_library.dart';
import '../../../../app_core/utils/animated_navigation.dart';
import '../../../../app_core/utils/number_helper.dart';
import '../../../../app_core/widgets/back_widget.dart';
import '../../../../app_core/widgets/error_flash_bar.dart';
import '../../../../app_core/widgets/loading_widget.dart';
import '../../../../resources/resources.dart';
import '../../../auth/presentation/cubit/session/session_cubit.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';
import '../../core/entity/house_entity.dart';
import '../../core/entity/house_stuff_entity.dart';
import '../cubit/house_stuff/house_stuff_cubit.dart';
import '../widgets/favorite_button_widget.dart';
import '../widgets/house_stuff_widget.dart';
import 'main_screen.dart';

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
  late int currentImageIndex;
  late List<HouseStuffEntity> houseStuff;

  @override
  void initState() {
    super.initState();

    currentImageIndex = 0;
    houseStuff = [];

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
              SizedBox(
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
                      pagination: SwiperCustomPagination(
                        builder:
                            (BuildContext context, SwiperPluginConfig config) {
                          return Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 3.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    ...List.generate(
                                      config.itemCount,
                                      (index) => Expanded(
                                        child: Padding(
                                          padding:
                                              index == entity.images.length - 1
                                                  ? EdgeInsets.zero
                                                  : const EdgeInsets.only(
                                                      right: 10),
                                          child: Container(
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
                              SizedBox(height: 10.h),
                            ],
                          );
                        },
                      ),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            final imageProvider = ExtendedNetworkImageProvider(
                                entity.images[index]);
                            showImageViewer(context, imageProvider);
                          },
                          child: ExtendedImage.network(
                            entity.images[index],
                            fit: BoxFit.cover,
                            width: 390,
                            height: 228,
                            mode: ExtendedImageMode.gesture,
                            initGestureConfigHandler: (state) {
                              return GestureConfig(
                                minScale: 0.9,
                                animationMinScale: 0.7,
                                maxScale: 3.0,
                                animationMaxScale: 3.5,
                                speed: 1.0,
                                inertialSpeed: 100.0,
                                initialScale: 1.0,
                                inPageView: true,
                                initialAlignment: InitialAlignment.center,
                              );
                            },
                          ),
                        );
                      },
                    ),
                    Positioned(
                      right: 5.w,
                      top: 5.h,
                      child: FavoriteButtonWidget(
                        entity: widget.entity,
                      ),
                    ),
                    Positioned(
                      left: 5.w,
                      top: 5.h,
                      child: BackWidget(
                        onBack: () {
                          AnimatedNavigation.pushAndRemoveUntilFade(
                            context: context,
                            page: const MainScreen(index: 1),
                          );
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 3,
                      child: Container(
                        width: 58.r,
                        height: 24.r,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40.r),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 7.6,
                              color: Colors.black.withOpacity(0.25),
                              offset: const Offset(0, 1),
                            ),
                          ],
                          color: const Color(0xffFCFCFC),
                        ),
                        child: Center(
                          child: Text(
                            "${currentImageIndex + 1} / ${entity.images.length}",
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: const Color(0xff1A1E25),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  entity.houseTitle,
                  style: TextStyle(
                    fontSize: 20.sp,
                    height: 0,
                    fontWeight: FontWeight.w700,
                    color: AppStyle.blue,
                  ),
                ),
              ),
              SizedBox(height: 12.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  entity.houseType,
                  style: TextStyle(
                    fontSize: 13.sp,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 14.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      Svgs.tSquare,
                      width: 16.r,
                      height: 16.r,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      entity.square.toString(),
                      style: TextStyle(
                        fontSize: 20.sp,
                        height: 0,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff474747),
                      ),
                    ),
                    SizedBox(width: 40.w),
                    SvgPicture.asset(
                      Svgs.tRooms,
                      width: 14.r,
                      height: 14.r,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      entity.rooms.toString(),
                      style: TextStyle(
                        fontSize: 20.sp,
                        height: 0,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff474747),
                      ),
                    ),
                    SizedBox(width: 40.w),
                    SvgPicture.asset(
                      Svgs.tRestroom,
                      width: 14.r,
                      height: 14.r,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      entity.bathroom.toString(),
                      style: TextStyle(
                        fontSize: 20.sp,
                        height: 0,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xff474747),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  entity.description,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 12.sp,
                    color: AppStyle.darkGrey,
                  ),
                ),
              ),
              BlocConsumer<HouseStuffCubit, HouseStuffState>(
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
                    addAutomaticKeepAlives: true,
                    itemCount: houseStuff.length,
                    itemBuilder: (context, index) {
                      final stuff = houseStuff[index];

                      return HouseStuffWidget(
                        stuffEntity: stuff,
                      );
                    }, separatorBuilder: (BuildContext context, int index) => SizedBox(height: 10.h),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          color: const Color(0xffEBEBEB),
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22.r),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 18.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 14.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    if (BlocProvider.of<SessionCubit>(context).state
                        is SessionDisabled) {
                      AnimatedNavigation.push(
                        context: context,
                        page: const SignInScreen(),
                      );
                    } else {
                      // Handle authenticated scenario
                    }
                  },
                  child: Container(
                    width: 180.w,
                    height: 40.h,
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
                        "fillTheForm".tr(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16.sp,
                        ),
                      ),
                    ),
                  ).animate().shimmer(duration: 250.milliseconds).shimmer(
                        delay: 250.milliseconds,
                        angle: 180,
                      ),
                ),
                SizedBox(width: 20.w),
                Flexible(
                  child: Text(
                    NumberHelper.format(entity.price) +
                        '\$' +
                        "/" +
                        "perMonth".tr(),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                      color: const Color(0xff474747),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 30.h),
          ],
        ),
      ),
    );
  }
}
