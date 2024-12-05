import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../core/usecases/delete_user_houses_usecase.dart';

part 'delete_user_houses_state.dart';

class DeleteUserHousesCubit extends Cubit<DeleteUserHousesState> {
  final DeleteUserHousesUsecase deleteUserHousesUsecase;
  DeleteUserHousesCubit(this.deleteUserHousesUsecase) : super(DeleteUserHousesInitial());

  delete({required int publicationsId}) async {
    emit(DeleteUserHousesLoading());
    final response = await deleteUserHousesUsecase
        .call(DeleteUserUsecaseParams(publicationsId: publicationsId));

    response.fold((l){
      emit(DeleteUserHousesError(l.errorMessage));
    }, (r){
      emit(DeleteUserHousesDeleted(publicationsId));
    });
  }
}
