import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../app_core/widgets/error_flash_bar.dart';
import '../../core/entity/house_entity.dart';
import '../cubit/favorite/favorite_cubit.dart';
import '../cubit/favorite/favorite_state.dart';
import '../widgets/house_vertical_view_widget.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late List<HouseEntity> houses;
  int currentIndex = 0;

  @override
  void initState() {
    houses = [];
    BlocProvider.of<FavoriteHousesCubit>(context).load();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<FavoriteHousesCubit, FavoriteHousesState>(
          listener: (context, state) {
            if (state is FavoriteHousesError) {
              ErrorFlushBar("error").show(context);
            }
            if (state is FavoriteHousesLoaded) {
              if (mounted) {
                Future.delayed(Duration.zero, () {
                  houses = state.favoriteHouses;
                });
              }
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h),
                    Text(
                      "favorites".tr(),
                      style: TextStyle(
                        color: AppStyle.dark,
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 15.h),
                    HouseVerticalWidget(
                      houses: houses,
                    ),
                    SizedBox(height: 15.h),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
