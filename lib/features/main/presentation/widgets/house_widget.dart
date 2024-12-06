import 'package:card_swiper/card_swiper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../../../auth/presentation/cubit/session/session_cubit.dart';
import '../../../auth/presentation/screens/sign_in_screen.dart';
import '../../core/entity/house_entity.dart';
import '../cubit/favorite/favorite_cubit.dart';
import '../screens/house_detail_screen.dart';

class HouseWidget extends StatefulWidget {
  final HouseEntity houses;

  const HouseWidget({
    super.key,
    required this.houses,
  });

  @override
  State<HouseWidget> createState() => _HouseWidgetState();
}

class _HouseWidgetState extends State<HouseWidget> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    final favoriteCubit = BlocProvider.of<FavoriteHousesCubit>(context);
    isFavorite = favoriteCubit.isFavorite(widget.houses.id);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AnimatedNavigation.push(
            context: context, page: HouseDetailScreen(entity: widget.houses));
      },
      child: Container(
        height: 182.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          color: Colors.grey.shade100,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.9),
              spreadRadius: 1,
              blurRadius: 8,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(),
            _buildInfoSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection() {
    return SizedBox(
      width: 170.w,
      height: 182.h,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(
                right: Radius.circular(10.r), left: Radius.circular(10.r)),
            child: Swiper(
              itemCount: widget.houses.images.length,
              itemBuilder: (context, index) {
                return Image.network(
                  widget.houses.images[index],
                  fit: BoxFit.cover,
                );
              },
              pagination: const SwiperPagination(
                alignment: Alignment.bottomCenter,
                builder: DotSwiperPaginationBuilder(
                  activeColor: Colors.blueAccent,
                  color: Colors.grey,
                  size: 6.0,
                  activeSize: 8.0,
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: isFavorite ? Colors.red : Colors.white,
              ),
              onPressed: () {
                if (BlocProvider.of<SessionCubit>(context).state
                    is SessionDisabled) {
                  AnimatedNavigation.push(
                      context: context, page: const SignInScreen());
                } else {
                  if (isFavorite) {
                    BlocProvider.of<FavoriteHousesCubit>(context)
                        .deleteAllFavorites();
                  } else {
                    BlocProvider.of<FavoriteHousesCubit>(context)
                        .addFavorite(widget.houses);
                  }
                  setState(() => isFavorite = !isFavorite);
                }
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoSection() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.houses.houseTitle,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppStyle.dark,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              widget.houses.category,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppStyle.blue,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 5.h),
            Column(
              children: [
                _buildInfoItem(
                    Icons.meeting_room, widget.houses.beds.toString()),
                SizedBox(width: 10.w),
                _buildInfoItem(
                    Icons.bathroom, widget.houses.bathrooms.toString()),
                SizedBox(width: 10.w),
                _buildInfoItem(Icons.other_houses_outlined,
                    widget.houses.guests.toString()),
              ],
            ),
            Spacer(),
            Text(
              "${widget.houses.price} \$/monthly",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 8.h),
            SizedBox(
                width: 140.w,
                height: 30,
                child: ButtonWidget(
                    title: "moreDetails".tr(),
                    onTap: () {
                      AnimatedNavigation.push(
                          context: context,
                          page: HouseDetailScreen(entity: widget.houses));
                    }))
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(IconData icon, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16.sp,
          color: Colors.blueAccent,
        ),
        Text(""),
        SizedBox(width: 4.w),
        Text(
          value,
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
