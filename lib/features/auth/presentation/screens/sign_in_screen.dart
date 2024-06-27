import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:realtor_pass/app_core/app_core_library.dart';
import 'package:realtor_pass/app_core/widgets/button_widget.dart';
import 'package:realtor_pass/app_core/widgets/error_flash_bar.dart';
import 'package:realtor_pass/app_core/widgets/text_form_field_widget.dart';
import 'package:realtor_pass/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:realtor_pass/features/auth/presentation/cubit/current_user/current_user_cubit.dart';
import 'package:realtor_pass/features/auth/presentation/screens/confirm_otp_screen.dart';
import 'package:realtor_pass/features/main/presentation/screens/main_screen.dart';
import '../../../../app_core/widgets/back_widget.dart';
import '../../../../resources/resources.dart';
import 'forgot_password_screen.dart';
import 'sign_up_screen.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SafeArea(
          child:BlocListener<AuthCubit, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                ErrorFlushBar(state.message).show(context);
              }
              if (state is AuthLoginSuccess) {
                BlocProvider.of<CurrentUserCubit>(context).load();
                AnimatedNavigation.push(context: context, page: const MainScreen());
              }
            },
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10.h,),
                    const BackWidget(),
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
                      "signIn".tr(),
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
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    TextFormFieldWidget(
                      hintText: "12345",
                      controller: controllerPassword,
                      title: "password".tr(),
                      isPassword: true,
                    ),
                    SizedBox(
                      height: 46.h,
                    ),
                    ButtonWidget(
                        title: "get".tr(),
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<AuthCubit>(context).signIn(
                              email: controllerEmail.text,
                              password: controllerPassword.text,
                            );
                          }

                          AnimatedNavigation.push(
                            context: context,
                            page: ConfirmOTPScreen(
                              email: controllerEmail.text,
                            ),
                          );
                        }),
                    SizedBox(
                      height: 14.h,
                    ),
                    GestureDetector(
                      onTap: () =>
                          AnimatedNavigation.push(
                            context: context,
                            page: const SignUpScreen(),
                          ),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "dontHaveAnAccount".tr(),
                                style: TextStyle(
                                  color: AppStyle.dark,
                                  fontSize: 14.sp,
                                ),
                              ),
                              const TextSpan(text: ""),
                              TextSpan(
                                text: "signUp".tr(),
                                style: TextStyle(
                                  color: AppStyle.blue,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10.h,
                    ),
                    GestureDetector(
                      onTap: () =>
                          AnimatedNavigation.push(
                            context: context,
                            page: ForgotPasswordScreen(
                              email: controllerEmail.text,
                            ),
                          ),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "forgotPassword".tr(),
                                style: TextStyle(
                                    color: AppStyle.darkGrey,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              const TextSpan(text: " "),
                              TextSpan(
                                text: "recover".tr(),
                                style: TextStyle(
                                  color: AppStyle.blue,
                                  fontSize: 14.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16.h,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(
                              color: const Color(0xffA1A1A1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Text(
                          "or".tr(),
                          style: TextStyle(
                            color: const Color(0xffA1A1A1),
                            fontSize: 16.sp,
                          ),
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(
                              color: const Color(0xffA1A1A1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 61.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _social(
                          image: Svgs.tGoogle,
                          onTap: () {},
                        ),
                        SizedBox(
                          width: 14.w,
                        ),
                        _social(
                          image: Svgs.tFacebook,
                          onTap: () {},
                        ),
                        SizedBox(
                          width: 14.w,
                        ),
                        _social(
                          image: Svgs.tApple,
                          onTap: () {},
                        ),
                      ],
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

_social({required String image, required Function() onTap}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      height: 44.h,
      width: 76.w,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10.r),
          border: Border.all(color: AppStyle.darkGrey)),
      child: Center(
        child: SizedBox.square(
          dimension: 24.r,
          child: SvgPicture.asset(image),
        ),
      ),
    ),
  );
}
