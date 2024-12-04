import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtor_pass/features/main/presentation/screens/post_house_stuff_screen.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../../core/entity/house_post_entity.dart';

class HousePostSecondScreen extends StatefulWidget {
  final HousePostEntity entity;

  const HousePostSecondScreen({super.key, required this.entity});

  @override
  HousePostSecondScreenState createState() => HousePostSecondScreenState();
}

class HousePostSecondScreenState extends State<HousePostSecondScreen> {
  late HousePostEntity postEntity;

  @override
  void initState() {
    super.initState();
    postEntity = widget.entity;
  }

  void incrementCounter(String type) {
    setState(() {
      switch (type) {
        case 'guests':
          postEntity = postEntity.copyWith(guests: postEntity.guests + 1);
          break;
        case 'bathrooms':
          postEntity = postEntity.copyWith(bathrooms: postEntity.bathrooms + 1);
          break;
        case 'bedrooms':
          postEntity = postEntity.copyWith(bedrooms: postEntity.bedrooms + 1);
          break;
        case 'beds':
          postEntity = postEntity.copyWith(beds: postEntity.beds + 1);
          break;
      }
    });
  }

  void decrementCounter(String type) {
    setState(() {
      switch (type) {
        case 'guests':
          if (postEntity.guests > 0) {
            postEntity = postEntity.copyWith(guests: postEntity.guests - 1);
          }
          break;
        case 'bathrooms':
          if (postEntity.bathrooms > 0) {
            postEntity =
                postEntity.copyWith(bathrooms: postEntity.bathrooms - 1);
          }
          break;
        case 'bedrooms':
          if (postEntity.bedrooms > 0) {
            postEntity = postEntity.copyWith(bedrooms: postEntity.bedrooms - 1);
          }
          break;
        case 'beds':
          if (postEntity.beds > 0) {
            postEntity = postEntity.copyWith(beds: postEntity.beds - 1);
          }
          break;
      }
    });
  }

  buildCounter(String label, int value, String type) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label),
        Row(
          children: [
            buildIconButton(Icons.remove, () => decrementCounter(type)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Text(value.toString()),
            ),
            buildIconButton(Icons.add, () => incrementCounter(type)),
          ],
        ),
      ],
    );
  }

  buildIconButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xffDADADA), width: 1),
        borderRadius: BorderRadius.circular(50.r),
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Text(
                "share".tr(),
                style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 50.h,
              ),
              buildCounter('guests'.tr(), postEntity.guests, 'guests'),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Color(0xffDADADA),
              ),
              SizedBox(
                height: 10.h,
              ),
              buildCounter(
                  'bathrooms'.tr(), postEntity.bathrooms, 'bathrooms'),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Color(0xffDADADA),
              ),
              SizedBox(
                height: 10.h,
              ),
              buildCounter(
                  'bedrooms'.tr(), postEntity.bedrooms, 'bedrooms'),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Color(0xffDADADA),
              ),
              SizedBox(
                height: 10.h,
              ),
              buildCounter('beds'.tr(), postEntity.beds, 'beds'),
              SizedBox(
                height: 10.h,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 1,
                color: Color(0xffDADADA),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 230.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back_outlined)),
                  SizedBox(
                    width: 100.w,
                    child: ButtonWidget(
                      title: "next".tr(),
                      onTap: () {
                        bool hasMadeSelection = postEntity.guests > 0 ||
                            postEntity.bathrooms > 0 ||
                            postEntity.bedrooms > 0 ||
                            postEntity.beds > 0;

                        if (hasMadeSelection) {
                          // Proceed to navigate
                          AnimatedNavigation.push(
                            context: context,
                            page: PostHouseStuffScreen(
                              entity: postEntity,
                            ),
                          );
                        } else {
                          // Show an alert dialog
                          showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: Text('selection'.tr()),
                                content: Text('selectAtLeastOneOption'.tr()),
                                actions: [
                                  TextButton(
                                    child: Text('ok'.tr()),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  ),
                                ],
                              );
                            },
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
