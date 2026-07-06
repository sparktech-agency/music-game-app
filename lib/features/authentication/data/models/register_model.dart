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
    required super.isVerified,
    required super.firstName,
    required super.lastName,
    required super.nickName,
    super.profile,
    required super.createdAt,
  });

  factory RegisterResponseModel.fromJson(Map<String, dynamic> json) {

    final data = json['data'] as Map<String, dynamic>;

    final user = data['user'] as Map<String, dynamic>;

    return RegisterResponseModel(
      id: user['_id'] as String,
      email: user['email'] as String,
      role: user['role'] as String,
      isVerified: user['isVerified'] as bool? ?? false,
      firstName: user['firstName'] ?? "Unknown",
      lastName: user['lastName'] ?? "",
      nickName: user['nickName'] ?? "user",
      profile: user['profile'] as String?,
      createdAt: DateTime.parse(user['createdAt'] as String),
    );
  }
}
