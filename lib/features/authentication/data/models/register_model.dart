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
    required super.success,
    required super.message,
    super.email,
    super.role,
    super.isActive,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {
    // Postman response map matching
    final data = json['data'] as Map<String, dynamic>?;
    return RegisterResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      email: data?['email'],
      role: data?['role'],
      isActive: data?['isActive'],
    );
  }
}