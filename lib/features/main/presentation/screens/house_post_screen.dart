import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../../../../app_core/widgets/error_flash_bar.dart';
import '../../core/entity/house_post_entity.dart';
import '../../core/entity/house_type_entity.dart';
import '../cubit/house_type/house_type_cubit.dart';
import 'house_post_second_screen.dart';

class HousePostScreen extends StatefulWidget {
  const HousePostScreen({super.key});

  @override
  State<HousePostScreen> createState() => _HousePostScreenState();
}

class _HousePostScreenState extends State<HousePostScreen> {
  late List<HouseTypeEntity>houseTypeEntity;
  HouseTypeEntity? selectedCategory;
  HousePostEntity postEntity = HousePostEntity.empty();

  @override
  void initState() {
    super.initState();
    houseTypeEntity = [];
    initialize();
  }

  void onCategoryTap(HouseTypeEntity category) {
    setState(() {
      selectedCategory = selectedCategory == category ? null : category;
    });
  }
  initialize() async{
    await EasyLocalization.ensureInitialized().then((value) {
      BlocProvider.of<HouseTypeCubit>(context)
          .load(locale: context.locale.languageCode.toString());
    });

  }

  void onContinue() {
    if (selectedCategory != null) {
      postEntity = postEntity.copyWith(category: selectedCategory!.title);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HousePostSecondScreen(entity: postEntity,),
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
        child: BlocListener<HouseTypeCubit, HouseTypeState>(
          listener: (context, state) {
            if (state is HouseTypeError) {
              ErrorFlushBar("error").show(context);
            }
            if (state is HouseTypeLoaded) {
              if (mounted) {
                Future.delayed(
                  Duration.zero,
                      () {
                    setState(() {
                      houseTypeEntity = state.results.housesType;
                    });
                  },
                );
              }
            }
          },
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
                      height: MediaQuery
                          .of(context)
                          .size
                          .height * 0.6,
                      child: BlocBuilder<HouseTypeCubit, HouseTypeState>(
                        builder: (context, state) {
                          return GridView.builder(
                            gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: houseTypeEntity.length,
                            itemBuilder: (context, index) {
                              final category = houseTypeEntity[index];
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
                                        borderRadius: BorderRadius.circular(
                                            10.r),
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
                                              Image.network(category.image),
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
                          );
                        },
                      ),
                    ),
                  ),
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
                          title: "continue".tr(),
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
      ),
    );
  }
}