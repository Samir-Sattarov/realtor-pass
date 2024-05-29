import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../app_core/app_core_library.dart';
import '../../../core/entity/porters_entity.dart';
import '../../../core/usecases/posters_usecase.dart';

part 'posters_state.dart';

class PostersCubit extends Cubit<PostersState> {
  final GetPostersUsecase postersUsecase;
  PostersCubit(this.postersUsecase) : super(PostersInitial());
  load() async {
    final response = await postersUsecase.call(NoParams());
    response.fold((l) => emit(PostersError(message: l.errorMessage)),
        (r) => emit(PostersLoaded(posters: r)));
  }
}
