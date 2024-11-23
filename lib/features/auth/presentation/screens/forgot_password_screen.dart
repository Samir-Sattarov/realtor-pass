import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../app_core/utils/app_style.dart';
import '../../../../app_core/utils/form_validator.dart';
import '../../../../app_core/widgets/back_widget.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../../../../app_core/widgets/error_flash_bar.dart';
import '../../../../app_core/widgets/text_form_field_widget.dart';
import '../cubit/forgot_password/forgot_password_cubit.dart';
import 'confirm_new_password_screen.dart';
import 'confirm_otp_screen.dart';
import 'otp_for_reset_password.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final String email;
  const ForgotPasswordScreen({super.key, required this.email});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerRole = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ForgotPasswordCubit, ForgotPasswordState>(
        listener: (context, state) {
          if (state is ForgotPasswordError) {
            ErrorFlushBar(state.message).show(context);
          }
          if (state is ForgotPasswordSuccess) {
            AnimatedNavigation.push(
                context: context,
                page: OtpForResetPasswordScreen(email: controllerEmail.text));
          }
        },
        child: Form(
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
                    SizedBox(height: 20.h,),
                    Text(
                      "Please enter your email so we can send you a password reset code.".tr(),
                      style: TextStyle(
                        color: AppStyle.dark,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 58.h),
                    SizedBox(height: 21.h),
                    TextFormFieldWidget(
                      hintText: 'name@gmail.com'.tr(),
                      controller: controllerEmail,
                      validator: FormValidator.validateEmail,
                      title: "Email".tr(),
                    ),
                    SizedBox(height: 21.h),
                    TextFormFieldWidget(
                      hintText: 'owner'.tr(),
                      controller: controllerRole,
                      validator: FormValidator.empty,
                      title: "Role".tr(),
                    ),
                    SizedBox(height: 46.h),
                    ButtonWidget(
                        title: "send",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<ForgotPasswordCubit>(context)
                                .getCode(
                                    email: controllerEmail.text,
                                    role: controllerRole.text,
                                    isMobile: true);
                            AnimatedNavigation.push(
                                context: context,
                                page: OtpForResetPasswordScreen(email: controllerEmail.text));
                          }
                        }),
                    SizedBox(height: 14.h),
                    SizedBox(height: 40.h),
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
