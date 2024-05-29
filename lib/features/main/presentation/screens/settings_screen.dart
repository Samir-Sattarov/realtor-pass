import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app_core/utils/animated_navigation.dart';
import '../../../../app_core/utils/form_validator.dart';
import '../../../../app_core/widgets/back_widget.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../../../../app_core/widgets/error_flash_bar.dart';
import '../../../../app_core/widgets/text_form_field_widget.dart';
import '../../../auth/core/entities/user_entity.dart';
import '../../../auth/presentation/cubit/current_user/current_user_cubit.dart';
import '../../../auth/presentation/cubit/edit_current_user_cubit/edit_user_cubit.dart';
import '../../../auth/presentation/cubit/otp_code/otp_code_cubit.dart';
import '../../../auth/presentation/screens/confirm_otp_screen.dart';
import 'main_screen.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController controllerName = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late UserEntity userEntity;

  String lastEmail = "";

  @override
  void initState() {
    BlocProvider.of<CurrentUserCubit>(context).load();
    super.initState();
  }

  initialize(UserEntity user) {
    userEntity = user;
    controllerName.text = userEntity.username;
    lastEmail = userEntity.email;
    controllerEmail.text = userEntity.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CurrentUserCubit, CurrentUserState>(
        builder: (context, state) {
          if (state is CurrentUserLoaded) {
            initialize(state.user);
          }
          return Form(
            key: _formKey,
            child: SafeArea(
              child: BlocListener<EditUserCubit, EditUserState>(
                listener: (context, state) {
                  if (state is EditUserError) {
                    ErrorFlushBar(state.message).show(context);
                  }
                  if (state is EditUserCodeSended) {
                    AnimatedNavigation.push(
                      context: context,
                      page: ConfirmOTPScreen(
                        email: lastEmail,
                        onTapConfirm: (code) {
                          BlocProvider.of<OtpCodeCubit>(context)
                              .confirmForEditUser(
                            code: code,
                          );
                        },
                        onSuccess: () {
                          userEntity.username = controllerName.text;
                          userEntity.email = controllerEmail.text;
                          userEntity.password = controllerPassword.text;
                          BlocProvider.of<EditUserCubit>(context)
                              .edit(userEntity);

                          AnimatedNavigation.push(
                            context: context,
                            page: const MainScreen(),
                          );
                        },
                      ),
                    );
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const BackWidget(),
                      SizedBox(height: 10.h),
                      Text(
                        "mainInformation".tr(),
                        style: TextStyle(
                          fontSize: 20.sp,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xff1A1E25),
                        ),
                      ),
                      SizedBox(
                        height: 6.h,
                      ),
                      Text(
                        "settingsSubTitle".tr(),
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 0.01,
                        ),
                      ),
                      SizedBox(
                        height: 36.h,
                      ),
                      TextFormFieldWidget(
                        hintText: "name".tr(),
                        controller: controllerName,
                        validator: FormValidator.empty,
                      ),
                      SizedBox(height: 16.h),
                      TextFormFieldWidget(
                        hintText: "email".tr(),
                        controller: controllerEmail,
                        validator: FormValidator.validateEmail,
                      ),
                      SizedBox(height: 16.h),
                      TextFormFieldWidget(
                        hintText: "password".tr(),
                        controller: controllerPassword,
                        isPassword: true,
                        validator: FormValidator.password,
                      ),
                      SizedBox(height: 46.h),
                      ButtonWidget(
                        title: "save",
                        onTap: () {
                          if (_formKey.currentState!.validate()) {
                            BlocProvider.of<EditUserCubit>(context).getCode(
                              lastEmail,
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
