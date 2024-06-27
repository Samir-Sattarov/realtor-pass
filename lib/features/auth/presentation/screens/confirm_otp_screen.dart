import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:realtor_pass/app_core/widgets/error_flash_bar.dart';
import 'package:realtor_pass/features/main/presentation/screens/main_screen.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../cubit/otp_code/otp_code_cubit.dart';

class ConfirmOTPScreen extends StatefulWidget {
  final String email;
  final Function()? onSuccess;
  final Function(String code)? onTapConfirm;

  const ConfirmOTPScreen(
      {super.key, required this.email, this.onSuccess, this.onTapConfirm});

  @override
  State<ConfirmOTPScreen> createState() => _ConfirmOTPScreenState();

}


class _ConfirmOTPScreenState extends State<ConfirmOTPScreen> {
  @override
  void dispose(){
    BlocProvider.of<OtpCodeCubit>(context).emit;
  }
  final TextEditingController controllerCode = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return KeyboardDismissOnTap(
      child: Scaffold(
        body: SafeArea(
          child: BlocListener<OtpCodeCubit, OtpCodeState>(
            listener: (context, state) {
              if(state is OtpCodeError){
                ErrorFlushBar(state.message).show(context);
              }
              if (widget.onSuccess != null) {
                widget.onSuccess?.call();
              } else {
                AnimatedNavigation.push(
                  context: context,
                  page: const MainScreen(),
                );
              }
            },
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 55.h),
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
                    Text(
                      "signUp".tr(),
                      style: TextStyle(
                        color: AppStyle.blue,
                        fontSize: 32.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 45.h),
                    Text(
                      "enterCode".tr(),
                      style: TextStyle(
                        color: AppStyle.blue,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: "code".tr(),
                            style: TextStyle(
                              color: AppStyle.dark,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          const TextSpan(text: ""),
                          TextSpan(
                            text: widget.email,
                            style: TextStyle(
                              color: AppStyle.dark,
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 36.h),
                    Center(
                        child: SizedBox(
                          height: 48.h,
                          child: Pinput(
                            length: 6,
                            controller: controllerCode,
                            defaultPinTheme: PinTheme(
                              width: 48.w,
                              decoration: BoxDecoration(
                                  color: const Color(0xffF4F4F4),
                                  borderRadius: BorderRadius.circular(10.r),
                                  border: Border.all(
                                    color: const Color(0xffA1A1A1),
                                    width: 1,
                                  )),
                            ),
                          ),
                        )),
                    SizedBox(height: 10.h),
                    Center(
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () {},
                        child: Text(
                          "receive".tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppStyle.grey,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 161.h),
                    Center(
                      child: SizedBox(
                        width: 248.w,
                        child: Text(
                          "in60secGetCode".tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppStyle.grey,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 32.h),
                    ButtonWidget(
                      title: "confirm",
                      onTap: () {
                        if (controllerCode.length == 6) {
                          if (widget.onTapConfirm != null) {
                            widget.onTapConfirm!.call(controllerCode.text);
                          } else {
                            BlocProvider.of<OtpCodeCubit>(context).confirm(
                              code: controllerCode.text,
                            );
                          }
                        }
                        AnimatedNavigation.push(
                            context: context, page: const MainScreen());
                      },
                    ),
                    SizedBox(height: 8.h),
                    Center(
                      child: TextButton(
                        style: TextButton.styleFrom(padding: EdgeInsets.zero),
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          "goBack".tr(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: AppStyle.dark,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
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
  }
}
