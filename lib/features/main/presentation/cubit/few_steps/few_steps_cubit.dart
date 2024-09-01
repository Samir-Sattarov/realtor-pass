import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../app_core/app_core_library.dart';
import '../../../core/entity/few_steps_result_entity.dart';
import '../../../core/usecases/few_steps_usecase.dart';

part 'few_steps_state.dart';

class FewStepsCubit extends Cubit<FewStepsState> {
  final GetFewStepsUsecase fewStepsUsecase;
  FewStepsCubit(this.fewStepsUsecase) : super(FewStepsInitial());

  load({required String locale}) async {
    FewStepsLoading();
    final response = await fewStepsUsecase.call(ImportantStagesUsecaseParams(locale:locale ));
    response.fold((l) => emit(FewStepsError(l.errorMessage)),
        (r) => emit(FewStepsLoaded(r)));
  }
}
