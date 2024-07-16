import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../app_core/app_core_library.dart';
import '../../../core/entity/house_stuff_entity.dart';
import '../../../core/usecases/get_house_stuff_usecase.dart';

part 'house_stuff_state.dart';

class HouseStuffCubit extends Cubit<HouseStuffState> {
  final GetHouseStuffUsecase stuffUsecase;
  HouseStuffCubit(this.stuffUsecase) : super(HouseStuffInitial());

  load() async {
    emit(HouseStuffLoading());
    final response = await stuffUsecase.call(NoParams());
    response.fold((l) => emit(HouseStuffError(l.errorMessage)),
        (r) => emit(HouseStuffLoaded(houses: r.houseStuff)));
  }
}
