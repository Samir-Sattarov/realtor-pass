import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtor_pass/features/auth/presentation/screens/sign_in_screen.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../app_core/utils/animated_navigation.dart';
import '../../../../app_core/utils/app_style.dart';
import '../../../../app_core/utils/form_validator.dart';
import '../../../../app_core/widgets/back_widget.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../../../../app_core/widgets/error_flash_bar.dart';
import '../../../../app_core/widgets/text_form_field_widget.dart';
import '../../core/entities/user_entity.dart';
import '../cubit/confitm_password/confirm_password_cubit.dart';
import '../cubit/forgot_password/forgot_password_cubit.dart';

class NewPasswordScreen extends StatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  State<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends State<NewPasswordScreen> {
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerConfirmPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Получаем код из ForgotPasswordCubit
    final otpCode = BlocProvider.of<ForgotPasswordCubit>(context).otpCode;

    return Scaffold(
      body: Form(
        key: _formKey,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: SafeArea(
          child: BlocListener<ConfirmPasswordCubit, ConfirmPasswordState>(
            listener: (context, state) {
              if (state is ConfirmPasswordError) {
                ErrorFlushBar(state.message).show(context);
              }
              if (state is ConfirmPasswordSuccess) {
                AnimatedNavigation.push(
                  context: context,
                  page: const SignInScreen(),
                );
              }
            },
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
                        color: AppStyle.dark,
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
                      title: "enter new password".tr(),
                    ),
                    SizedBox(height: 21.h),
                    TextFormFieldWidget(
                      hintText: 'password'.tr(),
                      controller: controllerConfirmPassword,
                      validator: (value) => FormValidator.passwordConfirm(
                          value, controllerPassword),
                      title: "confirm new password".tr(),
                    ),
                    SizedBox(height: 46.h),
                    ButtonWidget(
                      title: "updatePassword".tr(),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          final password = controllerConfirmPassword.text;
                          // Используем OTP из ForgotPasswordCubit
                          BlocProvider.of<ConfirmPasswordCubit>(context).confirm(
                            password: password,
                            token: otpCode, // Передаём код
                            isMobile: true,
                          );
                        }
                      },
                    ),
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
