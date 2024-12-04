import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../../core/entity/house_post_entity.dart';
import 'house_post_location_screen.dart';

class HousePostThirdScreen extends StatefulWidget {
  final HousePostEntity entity;

  const HousePostThirdScreen({
    super.key,
    required this.entity,
  });

  @override
  State<HousePostThirdScreen> createState() => _HousePostThirdScreenState();
}

class _HousePostThirdScreenState extends State<HousePostThirdScreen> {
  late HousePostEntity postEntity;
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    postEntity = widget.entity;
    titleController.text = postEntity.title;
    descriptionController.text = postEntity.description;
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: KeyboardDismissOnTap(
        child: Scaffold(
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    SizedBox(height: 20.h),
                    Text(
                      "houseDescription".tr(),
                      style: TextStyle(
                          fontSize: 25.sp, fontWeight: FontWeight.w700),
                    ),
                    SizedBox(
                      height: 5.h,
                    ),
                    Text(
                      "shortDescription".tr(),
                      style: TextStyle(
                          fontWeight: FontWeight.w300, fontSize: 14.sp),
                    ),
                    SizedBox(height: 50.h),
                    TextFormField(
                      controller: titleController,
                      validator: FormValidator.empty,
                      maxLength: 40,
                      maxLines: null,
                      decoration: InputDecoration(
                          hintText: "enterHouseTitle".tr(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.w,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 20.h,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      validator: FormValidator.empty,
                      maxLength: 100,
                      maxLines: null,
                      decoration: InputDecoration(
                          hintText: "enterYourHouseDesc".tr(),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: Colors.grey,
                              width: 1.w,
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 320.h,
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
                              if (_formKey.currentState!.validate()) {
                                postEntity = postEntity.copyWith(
                                  title: titleController.text,
                                  description: descriptionController.text,
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HousePostLocationScreen(
                                      entity: postEntity,
                                    ),
                                  ),
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
          ),
        ),
      ),
    );
  }
}
