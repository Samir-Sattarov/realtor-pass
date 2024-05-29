import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../app_core/app_core_library.dart';
import '../../../core/entity/questions_result_entity.dart';
import '../../../core/usecases/questions_usecase.dart';

part 'questions_state.dart';

class QuestionsCubit extends Cubit<QuestionsState> {
  final QuestionsUsecase usecase;
  QuestionsCubit(this.usecase) : super(QuestionsInitial());

  load() async {
    emit(QuestionsLoading());
    final response = await usecase.call(NoParams());
    response.fold((l) => emit(QuestionsError(message: l.errorMessage)),
        (r) => emit(QuestionsLoaded(data: r)));
  }
}
