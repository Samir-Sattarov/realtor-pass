import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../features/auth/presentation/cubit/current_user/current_user_cubit.dart';
import '../../../features/main/presentation/cubit/support/support_cubit.dart';
import '../../widgets/button_widget.dart';
import '../../widgets/error_flash_bar.dart';
import '../../widgets/success_flash_bar.dart';
import '../../widgets/text_form_field_widget.dart';
import '../form_validator.dart';

class SupportBody extends StatefulWidget {
  const SupportBody({super.key});

  @override
  State<SupportBody> createState() => _SupportBodyState();
}

class _SupportBodyState extends State<SupportBody> {
  final TextEditingController controllerSubject = TextEditingController();
  final TextEditingController controllerFeedback = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: SizedBox(
        child: BlocListener<SupportCubit, SupportState>(
          listener: (context, state) {
            if (state is SupportError) {
              ErrorFlushBar(state.message).show(context);
            }
            if (state is SupportSend) {
              SuccessFlushBar('supportSuccessSend'.tr()).show(context);
            }
          },
          child: SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: const Icon(
                          Icons.close,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    "support".tr(),
                    style: TextStyle(
                      color: const Color(0xff474747),
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "supportDescription".tr(),
                    style: TextStyle(
                      color: const Color(0xff474747),
                      fontSize: 14.sp,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  TextFormFieldWidget(
                    hintText: "subject".tr(),
                    controller: controllerSubject,
                    validator: FormValidator.empty,
                  ),
                  SizedBox(height: 10.h),
                  TextFormFieldWidget(
                    hintText: "sendYourFeedbackOrAnyQuestions".tr(),
                    controller: controllerFeedback,
                    maxLines: 5,
                    validator: FormValidator.empty,
                  ),
                  SizedBox(
                    height: 50.h,
                  ),
                  ButtonWidget(
                    title: "send".tr(),
                    onTap: () {
                      print("$controllerFeedback");
                      if (_formKey.currentState!.validate()) {
                        final id =
                            BlocProvider.of<CurrentUserCubit>(context).user.id;
                        BlocProvider.of<SupportCubit>(context).send(
                          id,
                          controllerSubject.text,
                          controllerFeedback.text,
                        );
                      }
                    },
                  ),
                  SizedBox(height: 50.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
