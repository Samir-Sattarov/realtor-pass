import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/entity/house_post_entity.dart';
import '../../../core/usecases/post_house_usecase.dart';
part  'house_post_state.dart';

class HousePostCubit extends Cubit<HousePostState> {
  final PostHouseUsecase postUsecase;
  HousePostCubit(this.postUsecase) : super(HousePostInitial());

  send(HousePostEntity entity) async {
    emit(HousePostLoading());
    final response = await postUsecase.call(
      PostHouseUsecaseParams(entity),
    );
    response.fold(
          (l) => emit(HousePostError(l.errorMessage)),
          (r) => emit(HousePostLoaded([entity])), // Assuming you want to load the posted entity
    );
  }
}