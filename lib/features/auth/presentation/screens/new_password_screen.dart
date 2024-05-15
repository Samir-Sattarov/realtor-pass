import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app_core/utils/animated_navigation.dart';
import '../../../../app_core/utils/app_style.dart';
import '../../../../app_core/utils/form_validator.dart';
import '../../../../app_core/widgets/back_widget.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../../../../app_core/widgets/error_flash_bar.dart';
import '../../../../app_core/widgets/text_form_field_widget.dart';

class NewPasswordScreen extends StatefulWidget {
  final String email;
  const NewPasswordScreen({
    super.key,
    required this.email,
  });

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerConfirmPassword =
      TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SafeArea(
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 55.h),
                  Row(
                    children: [
                      const BackWidget(),
                      SizedBox(width: 10.w),
                      Text(
                        "appName".tr(),
                        style: TextStyle(
                          fontStyle: FontStyle.italic,
                          color: AppStyle.dark,
                          fontSize: 20.sp,
                          height: 0,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    "setNewPassword".tr(),
                    style: TextStyle(
                      color: AppStyle.blue,
                      fontSize: 32.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 58.h),
                  SizedBox(height: 21.h),
                  TextFormFieldWidget(
                    hintText: 'password'.tr(),
                    controller: controllerPassword,
                    validator: FormValidator.password,
                    title: "enterNewPassword".tr(),
                  ),
                  SizedBox(height: 20.h,),
                  TextFormFieldWidget(
                    hintText: 'password'.tr(),
                    controller: controllerConfirmPassword,
                    validator: (value) => FormValidator.passwordConfirm(
                        value, controllerPassword),
                    title: "confirmNwPassword".tr(),
                  ),
                  SizedBox(height: 46.h),
                  ButtonWidget(
                    title: "updatePassword".tr(),
                    onTap: () {},
                  ),
                  SizedBox(height: 14.h),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
