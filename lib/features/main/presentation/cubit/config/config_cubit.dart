import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

import '../../../../../app_core/app_core_library.dart';
import '../../../core/entity/config_entity.dart';
import '../../../core/usecases/config_usecase.dart';

part 'config_state.dart';

class ConfigCubit extends Cubit<ConfigState> {
  final GetConfigUsecase usecase;

  ConfigCubit(this.usecase) : super(ConfigInitial());

  load() async {
    emit(ConfigLoading());
    final response = await usecase.call(NoParams());
    response.fold((l) => ConfigError(l.errorMessage), (r) => ConfigLoaded(r));
  }
}
