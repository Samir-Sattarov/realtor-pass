import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/entity/house_entity.dart';
import '../../../core/entity/house_result_entity.dart';
import '../../../core/usecases/get_user_houses_usecase.dart';

part 'user_houses_state.dart';

class UserHousesCubit extends Cubit<UserHousesState> {
  final GetUserHousesUseCase useCase;
  UserHousesCubit(this.useCase) : super(UserHousesInitial());

  load({required String locale, required int userId}) async {
    emit(UserHousesLoading());

    final response =
        await useCase.call(GetUserHousesUsecaseParams(locale: locale, userId: userId));

    response.fold(
          (l) => emit(UserHousesError(l.errorMessage)),
          (r) => emit(UserHousesLoaded(resultEntity: r.houses)),
    );

  }
}
