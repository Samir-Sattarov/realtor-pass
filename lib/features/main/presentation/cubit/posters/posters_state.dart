part of 'posters_cubit.dart';

@immutable
abstract class PostersState extends Equatable {
  const PostersState();
}

class PostersInitial extends PostersState {
  @override
  List<Object> get props => [];
}

class PostersLoaded extends PostersState {
  final PostersEntity posters;

  const PostersLoaded({required this.posters});

  @override
  List<Object> get props => [posters.images.length];
}

class PostersError extends PostersState {
  final String message;

  const PostersError({required this.message});
  @override
  List<Object> get props => [message];
}

class PostersLoading extends PostersState {
  @override
  List<Object> get props => [];
}
