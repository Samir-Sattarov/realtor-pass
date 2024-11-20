import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/entity/house_selling_type_result_entity.dart';
import '../../../core/usecases/house_selling_type_usecase.dart';

part 'house_selling_type_state.dart';

class HouseSellingTypeCubit extends Cubit<HouseSellingTypeState> {
  final GetHouseSellingTypeUsecase usecase;

  HouseSellingTypeCubit(this.usecase) : super(HouseSellingTypeInitial());

   load({ required String locale}) async {
    emit(HouseSellingTypeLoading());

    final response =
        await usecase.call(GetHouseSellingTypeParams(locale: locale));

    response.fold(
      (l) => emit(HouseSellingTypeError()),
      (r) =>
          emit(HouseSellingTypeLoaded(resultEntity: r)),
    );
  }
}
