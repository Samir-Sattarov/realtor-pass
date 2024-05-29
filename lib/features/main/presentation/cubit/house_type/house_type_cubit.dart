import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:realtor_pass/app_core/app_core_library.dart';
import 'package:realtor_pass/features/main/core/entity/house_type_result_entity.dart';

import '../../../core/usecases/houses_usecase.dart';

part 'house_type_state.dart';

class HouseTypeCubit extends Cubit<HouseTypeState> {
  final GetHouseTypeUsecase usecase;
  HouseTypeCubit(this.usecase) : super(HouseTypeInitial());
  load() async {
    emit(HouseTypeLoading());
    final response = await usecase.call(NoParams());

    response.fold(
      (l) => emit(HouseTypeError(message: l.errorMessage)),
      (r) => emit(HouseTypeLoaded(r)),
    );
  }
}
