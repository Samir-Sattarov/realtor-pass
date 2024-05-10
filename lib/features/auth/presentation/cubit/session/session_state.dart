part of 'session_cubit.dart';

abstract class SessionState extends Equatable {
  const SessionState();
}

class SessionActive extends SessionState {
  @override
  List<Object> get props => [];
}


class SessionDisabled extends SessionState {
  @override
  List<Object> get props => [];
}
