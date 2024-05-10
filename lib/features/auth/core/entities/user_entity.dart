import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  late String username;
  late String email;
  late String password;
  final bool isVerified;
  // final List<CarEntity> rentedCars;
  // final List<CarEntity> favoriteCars;

  UserEntity({
    required this.id,
    required this.username,
    required this.email,
    required this.password,
    required this.isVerified,
    // required this.rentedCars,
    // required this.favoriteCars,
  });

  factory UserEntity.empty() {
    return UserEntity(
      id: -1,
      username: "",
      email: "",
      password: "",
      isVerified: false,
      // rentedCars: [],
      // favoriteCars: [],
    );
  }

  @override
  List<Object?> get props => [
        id,
      ];
}
