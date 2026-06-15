import 'package:music_game_app/features/authentication/domain/entities/login_entity.dart';

class LoginRequestModel {
  final String email;
  final String password;

  const LoginRequestModel({
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

class LoginResponseModel extends LoginEntity {
  const LoginResponseModel({
    required super.accessToken,
    required super.refreshToken,
    required super.id,
    required super.name,
    required super.email,
    required super.role,
    required super.isActive,
    required super.isVerified,
    required super.isDeleted,
    required super.createdAt,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final user = data['user'] as Map<String, dynamic>;

    return LoginResponseModel(
      accessToken: data['accessToken'] as String,
      refreshToken: data['refreshToken'] as String,
      id: user['_id'] as String,
      name: user['name'] ?? user['email'],
      email: user['email'] as String,
      role: user['role'] as String,
      isActive: user['isActive'] as String,
      isVerified: user['isVerified'] as bool,
      isDeleted: user['isDeleted'] as bool,
      createdAt: DateTime.parse(user['createdAt'] as String),
    );
  }
}