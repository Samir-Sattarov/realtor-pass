part of 'house_post_cubit.dart';

@immutable
abstract class HousePostState extends Equatable {}

class HousePostInitial extends HousePostState {
  @override
  List<Object?> get props => [];
}

class HousePostLoading extends HousePostState {
  @override
  List<Object?> get props => [];
}

class HousePostError extends HousePostState {
  final String message;

  HousePostError(this.message);

  @override
  List<Object?> get props => [message];
}

class HousePostSuccessful extends HousePostState {
  @override
  List<Object?> get props => [];
}

class HousePostLoaded extends HousePostState {
  final List<HousePostEntity> posts;

  HousePostLoaded(this.posts);

  @override
  List<Object?> get props => [posts];
}
