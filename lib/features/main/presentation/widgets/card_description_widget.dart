import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../core/entity/house_entity.dart';

class CardDescriptionWidget extends StatefulWidget {
  final Marker marker;
  final HouseEntity house;
  const CardDescriptionWidget({super.key, required this.marker,required  this.house});

  @override
  State<CardDescriptionWidget> createState() => _CardDescriptionWidgetState();
}

class _CardDescriptionWidgetState extends State<CardDescriptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: EdgeInsets.only(bottom: 20.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6.r),
      ),
      constraints: const BoxConstraints(minWidth: 100, maxWidth: 200),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Popup for a marker!',
            overflow: TextOverflow.fade,
            softWrap: false,
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 14.0.sp,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Position: ${widget.marker.position.latitude}, ${widget.marker.position.longitude}',
            style: TextStyle(fontSize: 12.0.sp),
          ),
        ],
      ),
    );
  }
}
