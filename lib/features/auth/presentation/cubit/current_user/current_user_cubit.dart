import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app_core/entities/no_params.dart';
import '../../../core/entities/user_entity.dart';
import '../../../core/usecases/user_usecases.dart';


part 'current_user_state.dart';


UserEntity _user = UserEntity.empty();

class CurrentUserCubit extends Cubit<CurrentUserState> {
  final GetCurrentUserUsecase getCurrentUserUsecase;
  CurrentUserCubit(this.getCurrentUserUsecase) : super(CurrentUserInitial());


  UserEntity get user => _user;

  set setUser(UserEntity user) => _user = user;

  load() async {
    emit(CurrentUserLoading());
    final response = await getCurrentUserUsecase.call(NoParams());

    response.fold(
      (l) {
        debugPrint("Current user error ${l.errorMessage}");
        emit(CurrentUserError(l.errorMessage));
      },
      (r) {
        _user = r;

        debugPrint("Current user is $_user");
        emit(CurrentUserLoaded(r));
      },
    );
  }
}
