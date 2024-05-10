import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../core/usecases/auth_usecases.dart';

part 'auth_sources_state.dart';

enum AuthSource {
  google,
  facebook,
  apple,
}

class AuthSourcesCubit extends Cubit<AuthSourcesState> {
  final AuthSourceUsecase authSourceUsecase;

  AuthSourcesCubit(this.authSourceUsecase) : super(AuthSourcesInitial());

  auth(AuthSource source) async {
    final response = await authSourceUsecase.call(
      AuthSourcesUsecaseParams(source: source),
    );

    response.fold(
      (l) => emit(AuthSourcesError(l.errorMessage)),
      (r) => emit(AuthSourcesSuccess(r)),
    );
  }
}
