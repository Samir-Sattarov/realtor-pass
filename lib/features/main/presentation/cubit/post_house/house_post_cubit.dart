import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/entity/house_post_entity.dart';
import '../../../core/usecases/post_house_usecase.dart';
part 'house_post_state.dart';

class HousePostCubit extends Cubit<HousePostState> {
  final PostHouseUsecase postHouseUseCase;

  HousePostCubit(this.postHouseUseCase) : super(HousePostInitial());

  Future<void> send(HousePostEntity entity) async {
    emit(HousePostLoading());
    final postResult =
        await postHouseUseCase(PostHouseUsecaseParams(entity));

    postResult.fold((error) => emit(HousePostError(error.errorMessage)),
        (_) => emit(HousePostSuccessful()));
  }
}
