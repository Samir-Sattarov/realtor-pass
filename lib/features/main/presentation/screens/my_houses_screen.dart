import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app_core/widgets/back_widget.dart';
import '../../../../app_core/widgets/error_flash_bar.dart';
import '../../../../app_core/widgets/loading_widget.dart';
import '../../../auth/presentation/cubit/current_user/current_user_cubit.dart';
import '../../core/entity/house_entity.dart';
import '../cubit/delete_user_houses/delete_user_houses_cubit.dart';
import '../cubit/delete_user_houses/delete_user_houses_cubit.dart';
import '../cubit/user_houses/user_houses_cubit.dart';
import '../widgets/user_houses_widget.dart';

class MyHousesScreen extends StatefulWidget {
  const MyHousesScreen({super.key});

  @override
  State<MyHousesScreen> createState() => _MyHousesScreenState();
}

class _MyHousesScreenState extends State<MyHousesScreen> {
  List<HouseEntity> listHouses = [];
  @override
  void initState() {
    listHouses.clear();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final userId = context.read<CurrentUserCubit>().user.id;
    context.read<UserHousesCubit>().load(
          userId: userId,
          locale: context.locale.languageCode,
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocListener(
          listeners: [
            BlocListener<DeleteUserHousesCubit, DeleteUserHousesState>(
              listener: (context, state) {
                if (state is DeleteUserHousesDeleted) {
                  listHouses.removeWhere(
                    (element) => element.id == state.id,
                  );
                  if (mounted) {
                    Future.delayed(
                      Duration.zero,
                      () {
                        setState(() {});
                      },
                    );
                  }
                }
              },
            ),
            BlocListener<UserHousesCubit, UserHousesState>(
              listener: (context, state) {
                if (state is UserHousesError) {
                  ErrorFlushBar(state.message).show(context);
                }
                if (state is UserHousesLoaded) {
                  if (mounted) {
                    Future.delayed(
                      Duration.zero,
                      () {
                        listHouses = state.resultEntity;
                        setState(() {});
                      },
                    );
                  }
                }
              },
            ),
          ],
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    const BackWidget(),
                    SizedBox(
                      width: 100.w
                    ),
                    Text(
                      "myHouses".tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocBuilder<UserHousesCubit, UserHousesState>(
                  builder: (context, state) {
                    if (state is UserHousesLoading) {
                      return const Center(child: LoadingWidget());
                    }
                    return ListView.separated(
                      itemCount: listHouses.length,
                      padding: EdgeInsets.symmetric(horizontal: 20.w),
                      separatorBuilder: (context, index) =>
                          SizedBox(height: 10.h),
                      itemBuilder: (context, index) {
                        final house = listHouses[index];
                        return UserHousesWidget(
                          houses: house,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
