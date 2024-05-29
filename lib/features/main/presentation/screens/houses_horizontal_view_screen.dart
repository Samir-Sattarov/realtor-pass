import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtor_pass/features/main/core/entity/house_entity.dart';
import 'package:realtor_pass/features/main/presentation/cubit/houses/houses_cubit.dart';
import 'package:realtor_pass/features/main/presentation/widgets/house_widget.dart';
import 'package:realtor_pass/features/main/presentation/widgets/map_widget.dart';

class HousesHorizontalViewScreen extends StatefulWidget {
  final HouseEntity entity;
  const HousesHorizontalViewScreen({super.key, required this.entity});

  @override
  State<HousesHorizontalViewScreen> createState() =>
      _HousesHorizontalViewScreenState();
}

class _HousesHorizontalViewScreenState
    extends State<HousesHorizontalViewScreen> {
  late int currentImageIndex;

  @override
  void initState() {
    super.initState();
  }

  late List<HouseEntity> houses;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Stack(children: [
              // const MapWidget(
              //   fullScreen: true,
              // ),
              Column(
                children: [
                  BlocListener<HousesCubit, HousesState>(
                    listener: (context, state) {},
                    child: HouseWidget(
                      houses: widget.entity,
                      isHorizontalViewWidget: true,
                    ),
                  ),
                ],
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
