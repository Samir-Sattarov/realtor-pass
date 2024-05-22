import 'package:bloc/bloc.dart';

enum ScreenIndex {
  home,
  catalog,
  favorite,
  profile,
}

class BottomNavCubit extends Cubit<int> {
  BottomNavCubit() : super(-1);
  change(ScreenIndex screen) {
    emit(screen.index);
    Future.delayed(Duration.zero, () => emit(-1));
  }
}
