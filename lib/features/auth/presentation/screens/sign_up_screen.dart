import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realtor_pass/app_core/app_core_library.dart';
import 'package:realtor_pass/app_core/widgets/button_widget.dart';
import 'package:realtor_pass/app_core/widgets/error_flash_bar.dart';
import 'package:realtor_pass/app_core/widgets/text_form_field_widget.dart';
import 'package:realtor_pass/features/auth/presentation/cubit/registration/registration_cubit.dart';
import 'package:realtor_pass/features/auth/presentation/screens/confirm_otp_screen.dart';
import '../../../../app_core/utils/app_style.dart';
import '../../../../app_core/widgets/back_widget.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final TextEditingController controllerUsername = TextEditingController();
  final TextEditingController controllerRole = TextEditingController();
  final TextEditingController controllerPhone =  TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child: BlocListener<RegistrationCubit, RegistrationState>(
            listener: (context, state) {
              if (state is RegistrationError) {
                ErrorFlushBar(state.message).show(context);
              }
              if (state is RegistrationSuccess) {
                AnimatedNavigation.push(
                  context: context,
                  page: ConfirmOTPScreen(
                    email: controllerEmail.text,
                  ),
                );
              }
            },
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 20.h,),
                    BackWidget(),
                    SizedBox(
                      height: 10.h,
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
                      height: 30.h,
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
                      hintText: "+998979106225",
                      controller: controllerPhone,
                      title: "Phone number".tr(),
                      validator: FormValidator.empty,
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    TextFormFieldWidget(
                      hintText: "name",
                      controller: controllerUsername,
                      title: "userName".tr(),
                      validator: FormValidator.empty,
                    ),
                    SizedBox(
                      height: 21.h,
                    ),
                    TextFormFieldWidget(
                      hintText: "password",
                      controller: controllerPassword,
                      title: "Password".tr(),
                      validator: FormValidator.password,
                    ),
                    SizedBox(height: 21.h,),
                    TextFormFieldWidget(
                      hintText: "Role",
                      controller: controllerRole,
                      title: "Select the role".tr(),
                      validator: FormValidator.empty,
                    ),
                    SizedBox(height: 21.h,),
                    SizedBox(
                      height: 64.h,
                    ),
                    ButtonWidget(
                      title: "get".tr(),
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          BlocProvider.of<RegistrationCubit>(context).signUp(
                            email: controllerEmail.text,
                            username: controllerUsername.text,
                            password: controllerPassword.text,
                            role: controllerRole.text,
                            phone:  controllerPhone.text
                          );
                        }
                      },
                    ),
                    SizedBox(
                      height: 14.h,
                    ),
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
        ),
      ),
    );
  }
}
