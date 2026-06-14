import 'package:music_game_app/features/authentication/domain/entities/register_entity.dart';

class RegisterRequestModel {
  final String email;
  final String password;

  const RegisterRequestModel({
    required this.email,
    required this.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }
}

class RegisterResponseModel extends RegisterEntity {
  const RegisterResponseModel({
    required super.id,
    required super.email,
    required super.role,
    required super.isActive,
    required super.isVerified,
    required super.isDeleted,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;

    return RegisterResponseModel(
      id: data['_id'] as String,
      email: data['email'] as String,
      role: data['role'] as String,
      isActive: data['isActive'] as String,
      isVerified: data['isVerified'] as bool,
      isDeleted: data['isDeleted'] as bool,
    );
  }
}