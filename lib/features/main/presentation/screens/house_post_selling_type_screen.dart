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
import '../../core/entity/house_selling_type_entity.dart';
import '../cubit/house_selling_type/house_selling_type_cubit.dart';
import '../cubit/house_type/house_type_cubit.dart';
import 'house_post_price_screen.dart';

class HousePostSellingTypeScreen extends StatefulWidget {
  final HousePostEntity entity;

  const HousePostSellingTypeScreen({super.key, required this.entity});

  @override
  State<HousePostSellingTypeScreen> createState() =>
      _HousePostSellingTypeScreenState();
}

class _HousePostSellingTypeScreenState
    extends State<HousePostSellingTypeScreen> {
  late List<HouseSellingTypeEntity> houseSellingType;
  HouseSellingTypeEntity? selectedHouseSellingType;
  late HousePostEntity postEntity;

  @override
  void initState() {
    super.initState();
    houseSellingType = [];
    postEntity = widget.entity;
    selectedHouseSellingType;
    initialize();
  }

  void onCategoryTap(HouseSellingTypeEntity sellingType) {
    setState(() {
      selectedHouseSellingType =
          selectedHouseSellingType == sellingType ? null : sellingType;
    });
  }

  initialize() async {
    await EasyLocalization.ensureInitialized().then((value) {
      // ignore: use_build_context_synchronously
      BlocProvider.of<HouseSellingTypeCubit>(context)
          // ignore: use_build_context_synchronously
          .load(locale: context.locale.languageCode.toString());
    });
  }

  void onContinue() {
    if (selectedHouseSellingType != null) {
      postEntity =
          postEntity.copyWith(type: selectedHouseSellingType!.id); // int
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HousePostPriceScreen(
            entity: postEntity,
          ),
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
                  Navigator.of(context).pop();
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
        child: BlocListener<HouseSellingTypeCubit, HouseSellingTypeState>(
          listener: (context, state) {
            if (state is HouseTypeError) {
              ErrorFlushBar("error").show(context);
            }
            if (state is HouseSellingTypeLoaded) {
              if (mounted) {
                Future.delayed(
                  Duration.zero,
                  () {
                    setState(() {
                      houseSellingType = state.resultEntity.houseSellingType;
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
                    'sellOrRent'.tr(),
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
                      child: BlocBuilder<HouseTypeCubit, HouseTypeState>(
                        builder: (context, state) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 2.4,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: houseSellingType.length,
                            itemBuilder: (context, index) {
                              final sellingType = houseSellingType[index];
                              final isSelected =
                                  selectedHouseSellingType == sellingType;
                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(10.r),
                                  splashColor: Colors.white30,
                                  onTap: () => onCategoryTap(sellingType),
                                  child: Ink(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10.r),
                                      border: Border.all(
                                          color: isSelected
                                              ? Colors.transparent
                                              : Colors.grey.shade200,
                                          width: 2.w),
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
                                            SizedBox(
                                              height: 64.r,
                                              width: 64.r,
                                              child: Center(
                                                  child: Image.network(
                                                sellingType.url,
                                                fit: BoxFit.contain,
                                              )),
                                            ),
                                            SizedBox(height: 10.h),
                                            FittedBox(
                                              child: Text(
                                                sellingType.title,
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
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                  SizedBox(height: 10.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      if (selectedHouseSellingType == null)
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
