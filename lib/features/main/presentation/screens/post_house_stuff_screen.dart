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
import '../../core/entity/house_stuff_entity.dart';
import '../cubit/house_stuff/house_stuff_cubit.dart';
import 'house_post_third_screen.dart';

class PostHouseStuffScreen extends StatefulWidget {
  const PostHouseStuffScreen({super.key});

  @override
  State<PostHouseStuffScreen> createState() => _PostHouseStuffScreenState();
}

class _PostHouseStuffScreenState extends State<PostHouseStuffScreen> {
  late List<HouseStuffEntity> houseStuffEntity;
  HousePostEntity postEntity = HousePostEntity.empty();
  List<String> selectedFeatures = [];

  @override
  void initState() {
    super.initState();
    houseStuffEntity = [];
    selectedFeatures = [];
    initialize();
  }

  void onCategoryTap(HouseStuffEntity features) {
    setState(() {
      if (selectedFeatures.contains(features.title)) {
        selectedFeatures.remove(features.title);
      } else {
        selectedFeatures.add(features.title);
      }
    });
  }

  initialize() async {
    await EasyLocalization.ensureInitialized().then((value) {
      BlocProvider.of<HouseStuffCubit>(context)
          .load(locale: context.locale.languageCode.toString());
    });
  }

  void onContinue() {
    if (selectedFeatures.isNotEmpty) {
      postEntity = postEntity.copyWith(features: selectedFeatures);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>  HousePostThirdScreen(entity: postEntity),
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text("error".tr()),
            content: Text("selectFeatures".tr()),
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
        child: BlocListener<HouseStuffCubit, HouseStuffState>(
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
                      houseStuffEntity = state.data;
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
                    'tell'.tr(),
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
                      child: BlocBuilder<HouseStuffCubit, HouseStuffState>(
                        builder: (context, state) {
                          return GridView.builder(
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              childAspectRatio: 3 / 2,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10,
                            ),
                            itemCount: houseStuffEntity.length,
                            itemBuilder: (context, index) {
                              final features = houseStuffEntity[index];
                              final isSelected =
                                  selectedFeatures.contains(features.title);
                              return Material(
                                color: Colors.transparent,
                                child: AnimatedSwitcher(
                                  duration: const Duration(milliseconds: 1000),
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(10.r),
                                    splashColor: Colors.white30,
                                    onTap: () => onCategoryTap(features),
                                    child: Ink(
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.r),
                                        border: Border.all(
                                          color: isSelected
                                              ? Colors.transparent
                                              : Colors.grey.shade200,
                                          width: 2,
                                        ),
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
                                              Image.network(features.image),
                                              SizedBox(height: 10.h),
                                              FittedBox(
                                                child: Text(
                                                  features.title,
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
                  SizedBox(height: 10.h,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: const Icon(Icons.arrow_back_outlined)),
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
      ),
    );
  }
}
