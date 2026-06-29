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
    required super.email,
    required super.role,
    required super.isVerified,
    required super.firstName,
    required super.lastName,
    required super.nickName,
    super.profile,
    required super.createdAt,
  });

  factory LoginResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final user = data['user'] as Map<String, dynamic>;

    return LoginResponseModel(
      accessToken: data['accessToken'] as String,
      refreshToken: data['refreshToken'] as String,
      id: user['_id'] as String,
      email: user['email'] as String,
      role: user['role'] as String,
      isVerified: user['isVerified'] as bool,
      firstName: user['firstName'] ?? "Unknown",
      lastName: user['lastName'] ?? "",
      nickName: user['nickName'] ?? "",
      profile: user['profile'],
      createdAt: DateTime.parse(user['createdAt'] as String),
    );
  }
}