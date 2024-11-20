import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../app_core/app_core_library.dart';
import '../../../core/entity/config_entity.dart';
import '../../../core/usecases/config_usecase.dart';

part 'config_state.dart';

class ConfigCubit extends Cubit<ConfigState> {
  final GetConfigUsecase getConfig;

  ConfigCubit(this.getConfig) : super(ConfigInitial());

  String _redirectLink = "";

  String get redirectLink => _redirectLink;

  load() async {
    final response = await getConfig.call(NoParams());

    response.fold(
          (l) => emit(ConfigError(l.errorMessage)),
          (r) {
        _redirectLink = r.redirectLink;
        emit(ConfigLoaded(r));
      },
    );
  }
}
