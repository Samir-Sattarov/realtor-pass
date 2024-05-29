import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../app_core/app_core_library.dart';
import '../../../core/entity/profitable_terms_result_entity.dart';
import '../../../core/usecases/profitable_terms_usecase.dart';

part 'profitable_terms_state.dart';

class ProfitableTermsCubit extends Cubit<ProfitableTermsState> {
  final GetProfitableTermsUsecase usecase;
  ProfitableTermsCubit(this.usecase) : super(ProfitableTermsInitial());
  load() async {
    emit(ProfitableTermsLoading());
    final response = await usecase.call(NoParams());
    response.fold((l) => ProfitableTermsError(l.errorMessage),
        (r) => ProfitableTermsLoaded(r));
  }
}
