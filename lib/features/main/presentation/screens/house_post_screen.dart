import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../../core/entity/house_entity.dart';
import '../../core/entity/house_post_entity.dart';
import '../../core/entity/house_type_entity.dart';
import 'house_post_second_screen.dart';

class HousePostScreen extends StatefulWidget {
  const HousePostScreen({super.key});

  @override
  State<HousePostScreen> createState() => _HousePostScreenState();
}

class _HousePostScreenState extends State<HousePostScreen> {
  late List<HouseTypeEntity> entity;
  late List<HouseEntity> houseEntity;
  HouseTypeEntity? selectedCategory;
  HousePostEntity postEntity = HousePostEntity.empty();

  @override
  void initState() {
    super.initState();
    houseEntity = [];
    entity = [
      HouseTypeEntity(
        id: 1,
        title: 'House',
      ),
      HouseTypeEntity(
        id: 2,
        title: 'Apartment',
      ),
      HouseTypeEntity(
        id: 3,
        title: 'Barn',
      ),
      HouseTypeEntity(
        id: 4,
        title: 'Bed & breakfast',
      ),
      HouseTypeEntity(
        id: 5,
        title: 'Boat',
      ),
      HouseTypeEntity(
        id: 6,
        title: 'Cabin',
      ),
      HouseTypeEntity(
        id: 7,
        title: 'Camper/RV',
      ),
      HouseTypeEntity(
        id: 8,
        title: 'Casa particular',
      ),
    ];
  }

  void onCategoryTap(HouseTypeEntity category) {
    setState(() {
      if (selectedCategory == category) {
        selectedCategory = null;
      } else {
        selectedCategory = category;
      }
    });
  }

  void onContinue() {
    if (selectedCategory != null) {

      postEntity = postEntity.copyWith(category: selectedCategory!.title);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>   HousePostSecondScreen(entity: postEntity,),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("error".tr()),
            content: Text("select".tr()),
            actions: <Widget>[
              TextButton(
                child: Text(
                  "OK",
                  style: TextStyle(color: Colors.black, fontSize: 12.sp),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Dismiss the dialog
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Column(
              children: [
                Text(
                  'describeYourPlace'.tr(),
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 25.sp,
                  ),
                ),
                SizedBox(
                  height: 50.h,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.6,
                    child: GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3 / 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: entity.length,
                      itemBuilder: (context, index) {
                        final category = entity[index];
                        final isSelected = selectedCategory == category;
                        return Material(
                          color: Colors.transparent,
                          child: AnimatedSwitcher(
                            duration: Duration(milliseconds: 1000),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(10.r),
                              splashColor: Colors.white30,
                              onTap: () => onCategoryTap(category),
                              child: Ink(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                      color: isSelected
                                          ? Colors.transparent
                                          : Colors.grey.shade200,
                                      width: 2),
                                  color: isSelected
                                      ? AppStyle.blue
                                      : const Color(0xffFAFAFA),
                                ),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.add,
                                          size: 40.sp,
                                          color: isSelected
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                        SizedBox(height: 10.h),
                                        FittedBox(
                                          child: Text(
                                            category.title,
                                            style: TextStyle(
                                              fontSize: 16.sp,
                                              color: isSelected
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                // if (selectedCategory != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if (selectedCategory == null)
                      Expanded(
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(Icons.arrow_back_outlined),
                        ),
                      ),
                    Expanded(
                      flex: 4,
                      child: ButtonWidget(
                        title: "Continue",
                        onTap: () {
                          onContinue();
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
