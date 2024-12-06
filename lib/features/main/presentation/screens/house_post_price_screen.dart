import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app_core/app_core_library.dart';
import '../../../../app_core/widgets/button_widget.dart';
import '../../../../app_core/widgets/error_flash_bar.dart';
import '../../../../app_core/widgets/loading_widget.dart';
import '../../../../app_core/widgets/success_flash_bar.dart';
import '../../../auth/presentation/cubit/auth/auth_cubit.dart';
import '../../../auth/presentation/cubit/current_user/current_user_cubit.dart';
import '../../core/entity/house_post_entity.dart';
import '../cubit/post_house/house_post_cubit.dart';
import 'main_screen.dart';

class HousePostPriceScreen extends StatefulWidget {
  final HousePostEntity entity;

  const HousePostPriceScreen({
    super.key,
    required this.entity,
  });

  @override
  State<HousePostPriceScreen> createState() => _HousePostPriceScreenState();
}

class _HousePostPriceScreenState extends State<HousePostPriceScreen> {
  late HousePostEntity postEntity;
  final TextEditingController controllerPrice = TextEditingController();
  final TextEditingController controllerPhone = TextEditingController();
  final TextEditingController controllerEmail = TextEditingController();

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
            child: BlocConsumer<HousePostCubit, HousePostState>(
              listener: (context, state) {
                if (state is HousePostError) {
                  ErrorFlushBar(state.message).show(context);
                }
                if (state is HousePostSuccessful) {
                  SuccessFlushBar('homeCreated'.tr()).show(context);
                  AnimatedNavigation.push(
                      context: context, page: const MainScreen());
                }
                SuccessFlushBar("yourHomeCreated".tr()).show(context);
              },
              builder: (context, state) {
                if (state is HousePostLoading) {
                  return const Center(child: LoadingWidget());
                }

                return SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "setHomePrice".tr(),
                          style: TextStyle(
                            fontSize: 20.sp,
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
                        SizedBox(height: 80.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text("price".tr()),
                        ),
                        SizedBox(
                          width: 370.w,
                          child: TextFormField(
                            controller: controllerPrice,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.r),
                                borderSide:
                                    const BorderSide(color: Colors.grey),
                              ),
                              prefixText: '\$',
                              prefixStyle: TextStyle(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.h),
                          child: Text("phone".tr()),
                        ),
                        SizedBox(
                          width: 370.w,
                          child: TextFormField(
                            controller: controllerPhone,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.r),
                                  borderSide:
                                      const BorderSide(color: Colors.grey)),
                              hintText: "+998999999999",
                            ),
                            keyboardType: TextInputType.phone,
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10.w),
                          child: Text("email".tr()),
                        ),
                        SizedBox(
                          width: 370.w,
                          child: TextFormField(
                            controller: controllerEmail,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                            ),
                            textAlign: TextAlign.start,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                    borderSide:
                                        const BorderSide(color: Colors.grey)),
                                hintText: "name@gmail.com"),
                            keyboardType: TextInputType.emailAddress,
                          ),
                        ),
                        SizedBox(height: 220.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: const Icon(Icons.arrow_back_outlined),
                            ),
                            SizedBox(width: 10.w),
                            Expanded(
                              child: ButtonWidget(
                                title: "next".tr(),
                                onTap: () {
                                  final userId =  context.read<CurrentUserCubit>().user;
                                  if (_formKey.currentState!.validate()) {
                                    postEntity = postEntity.copyWith(
                                      phone: controllerPhone.text,
                                      email: controllerEmail.text,
                                      price: int.tryParse(controllerPrice.text),
                                      ownerId: userId.id
                                    );

                                    BlocProvider.of<HousePostCubit>(context)
                                        .send(postEntity);

                                    print('Images before sending: ${postEntity.images.photos.map((e) => e.id).toList()}');

                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
