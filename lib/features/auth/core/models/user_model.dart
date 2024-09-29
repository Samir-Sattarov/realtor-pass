import '../entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.username,
    required super.email,
    required super.password,
    required super.isVerified,
    // required super.favoriteCars,
  });

  factory UserModel.fromEntity(UserEntity entity) {
    return UserModel(
      id: entity.id,
      username: entity.username,
      email: entity.email,
      password: entity.password,
      isVerified: entity.isVerified,
      // rentedCars: entity.rentedCars,
      // favoriteCars: entity.favoriteCars,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ,
      username: json['username'],
      email: json['email'],
      password: json['password'] ?? "",
      isVerified: json['isVerified'],
      // rentedCars: const [],
      // favoriteCars: const [],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> json = {};
    json['username'] = username;
    json['email'] = email;
    json['password'] = password;

    return json;
  }
}
