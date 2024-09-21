import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../../core/entity/house_post_entity.dart';
import '../widgets/photo_card_widget.dart';

class HousePostPriceScreen extends StatefulWidget {
  final HousePostEntity entity;
  const HousePostPriceScreen({super.key, required this.entity});

  @override
  State<HousePostPriceScreen> createState() => _HousePostPriceScreenState();
}

class _HousePostPriceScreenState extends State<HousePostPriceScreen> {
  late HousePostEntity postEntity;
 final TextEditingController controllerPrice =  TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
    postEntity = widget.entity;
    controllerPrice.text = postEntity.price.toString();
  }

  @override
  void dispose() {
    controllerPrice.dispose();
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "setPrice".tr(),
                      style: TextStyle(
                        fontSize: 25.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "uCanChange".tr(),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(
                      height: 80.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 178,
                          child: TextFormField(
                            initialValue: '50',
                            style: TextStyle(
                              fontSize: 48.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              prefixText: '\$',
                              prefixStyle: TextStyle(
                                fontSize: 48.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 390.h,),
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
                                  price: int.tryParse(controllerPrice.text)
                                );
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ImagePickerExample(postEntity:  postEntity,),
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
