import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtor_pass/app_core/app_core_library.dart';
import 'package:realtor_pass/app_core/widgets/button_widget.dart';
import 'package:realtor_pass/app_core/widgets/text_form_field_widget.dart';
import '../../../../app_core/utils/app_style.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  TextEditingController controllerConfirmPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 50.h,
                ),
                Text(
                  "appName".tr(),
                  style: TextStyle(
                      color: AppStyle.darkGrey,
                      fontSize: 20.sp,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  "signUp".tr(),
                  style: TextStyle(
                      color: AppStyle.blue,
                      fontWeight: FontWeight.w700,
                      fontSize: 32.sp),
                ),
                SizedBox(
                  height: 58.h,
                ),
                TextFormFieldWidget(
                  hintText: "name@email.com",
                  controller: controllerEmail,
                  title: "email".tr(),
                  validator: FormValidator.validateEmail,
                ),
                SizedBox(
                  height: 21.h,
                ),
                TextFormFieldWidget(
                  hintText: "12345",
                  controller: controllerPassword,
                  title: "password".tr(),
                  validator: FormValidator.password,
                  isPassword: true,
                ),
                SizedBox(
                  height: 21.h,
                ),
                TextFormFieldWidget(
                  hintText: "12345",
                  isPassword: true,
                  controller: controllerConfirmPassword,
                  title: "confirm".tr(),
                  validator: (value) =>
                      FormValidator.passwordConfirm(value, controllerPassword),
                ),
                SizedBox(
                  height: 64.h,
                ),
                ButtonWidget(title: "Get a code", onTap: () {}),
                SizedBox(height: 14.h,),
                Center(
                  child: Text(
                    textAlign: TextAlign.center,
                    "byRegistering".tr(),
                    style: TextStyle(
                        color: AppStyle.blue,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.sp),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
