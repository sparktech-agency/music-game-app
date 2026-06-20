import 'package:music_game_app/features/authentication/domain/entities/reset_pass_entity.dart';

class ResetPassRequestModel {
  final String email;
  final String oldPassword;
  final String newPassword;

  const ResetPassRequestModel({
    required this.email,
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }
}

class ResetPassResponseModel extends ResetPassEntity {
  const ResetPassResponseModel({
    required super.success,
    required super.message,
  });

  factory ResetPassResponseModel.fromJson(Map<String, dynamic> json) {
    return ResetPassResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
    );
  }
}