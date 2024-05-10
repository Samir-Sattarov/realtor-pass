import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/entities/user_entity.dart';
import '../../../core/usecases/confirm_password_usecase.dart';
import '../../../core/usecases/user_usecases.dart';
import '../current_user/current_user_cubit.dart';

part 'edit_user_state.dart';

class EditUserCubit extends Cubit<EditUserState> {
  final EditCurrentUserUsecase editCurrentUserUsecase;
  final GetCodeForEditUserUsecase codeForEditUserUsecase;
  final CurrentUserCubit currentUserCubit;
  EditUserCubit(
    this.editCurrentUserUsecase,
    this.currentUserCubit,
    this.codeForEditUserUsecase,
  ) : super(EditUserInitial());

  getCode(String email) async {
    final response = await codeForEditUserUsecase
        .call(GetCodeForEditUserUsecaseParams(email: email));

    response.fold(
      (l) => emit(EditUserError(l.errorMessage)),
      (r) => emit(EditUserCodeSended()),
    );
  }

  edit(UserEntity user) async {
    emit(EditUserLoading());

    final response =
        await editCurrentUserUsecase.call(EditCurrentUserParams(user));

    response.fold(
      (l) => emit(EditUserError(l.errorMessage)),
      (r) {
        currentUserCubit.setUser = r;
        emit(EditUserSuccess());
      },
    );
  }



}
