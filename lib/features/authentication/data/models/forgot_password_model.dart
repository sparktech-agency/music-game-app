import 'package:music_game_app/features/authentication/domain/entities/forgot_password_entity.dart';

class ForgotPasswordRequestModel {
  final String email;

  const ForgotPasswordRequestModel({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}

class ForgotPasswordResponseModel extends ForgotPasswordEntity {
  const ForgotPasswordResponseModel({
    required super.success,
    required super.message,
  });

  factory ForgotPasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ForgotPasswordResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
    );
  }
}