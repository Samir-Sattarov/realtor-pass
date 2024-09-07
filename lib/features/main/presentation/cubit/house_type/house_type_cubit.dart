import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:realtor_pass/features/main/core/entity/house_type_result_entity.dart';
import '../../../core/usecases/houses_usecase.dart';
part 'house_type_state.dart';

class HouseTypeCubit extends Cubit<HouseTypeState> {
  final GetHouseTypeUsecase getHouseTypeUsecase;
  HouseTypeCubit(this.getHouseTypeUsecase) : super(HouseTypeInitial());

  load({required String locale}) async {
    emit(HouseTypeLoading());
    final response = await getHouseTypeUsecase.call(GetHousesTypeUsecaseParams(locale: locale));

    response.fold(
      (l) => emit(HouseTypeError(message: l.errorMessage)),
      (r) {

        print("Response ${r.housesType}");
        emit(HouseTypeLoaded(r));
      },
    );
  }
}
