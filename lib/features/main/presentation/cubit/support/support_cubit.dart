import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../core/usecases/feedback_usecase.dart';

part 'support_state.dart';

class SupportCubit extends Cubit<SupportState> {
  final FeedbackUsecase usecase;
  SupportCubit(this.usecase) : super(SupportInitial());

  send(int id, String subject, String feedback) async {
    final response =
        await usecase.call(FeedBackUsecaseParams(id, subject, feedback));
    emit(SupportLoading());
    response.fold((l) => SupportError(l.errorMessage), (r) => SupportSend());
  }
}
