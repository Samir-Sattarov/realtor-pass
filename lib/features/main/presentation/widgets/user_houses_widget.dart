import 'package:card_swiper/card_swiper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../../core/entity/house_entity.dart';
import '../cubit/delete_user_houses/delete_user_houses_cubit.dart';
import '../screens/house_detail_screen.dart';

class UserHousesWidget extends StatelessWidget {
  final HouseEntity houses;

  const UserHousesWidget({
    super.key,
    required this.houses,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AnimatedNavigation.push(
          context: context,
          page: HouseDetailScreen(entity: houses),
        );
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
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildImageSection(),
            _buildInfoSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildImageSection(  ) {
    return SizedBox(
      width: 170.w,
      height: 182.h,
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(
                right: Radius.circular(10.r), left: Radius.circular(10.r)),
            child: Swiper(
              itemCount: houses.images.length,
              itemBuilder: (context, index) {
                return Image.network(
                  houses.images[index],
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
        ],
      ),
    );
  }

  Widget _buildInfoSection(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    houses.houseTitle,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    BlocProvider.of<DeleteUserHousesCubit>(context)
                        .delete(publicationsId: houses.id);
                  },
                  icon: const Icon(Icons.delete),
                  color: Colors.red,
                ),
              ],
            ),
            Text(
              houses.category,
              style: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
                color: AppStyle.blue,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 10.h),
            Row(
              children: [
                _buildInfoItem(
                    Icons.meeting_room, houses.beds.toString()),
                SizedBox(width: 10.w),
                _buildInfoItem(
                    Icons.bathroom, houses.bathrooms.toString()),
                SizedBox(width: 10.w),
                _buildInfoItem(
                    Icons.bedroom_child_sharp, houses.guests.toString()),
              ],
            ),
            Spacer(),
            Text(
              "${houses.price} \$/monthly",
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
                title: "edit".tr(),
                onTap: () {},
              ),
            ),
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
