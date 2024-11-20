part of 'house_selling_type_cubit.dart';

abstract class HouseSellingTypeState extends Equatable {
  const HouseSellingTypeState();
}

class HouseSellingTypeInitial extends HouseSellingTypeState {
  @override
  List<Object> get props => [];
}
class HouseSellingTypeLoading extends HouseSellingTypeState {
  @override
  List<Object> get props => [];
}
class HouseSellingTypeLoaded extends HouseSellingTypeState {
  final HouseSellingTypeResultEntity resultEntity;

  HouseSellingTypeLoaded({required this.resultEntity});
  @override
  List<Object> get props => [resultEntity];
}
class HouseSellingTypeError extends HouseSellingTypeState {
  @override
  List<Object> get props => [];
}
