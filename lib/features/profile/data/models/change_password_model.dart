import 'package:music_game_app/features/profile/domain/entities/change_password_entity.dart';


//===== Request Model =====

class ChangePasswordRequestModel {
  final String oldPassword;
  final String newPassword;

  const ChangePasswordRequestModel({
    required this.oldPassword,
    required this.newPassword,
  });

  Map<String, dynamic> toJson() {
    return {
      'oldPassword': oldPassword,
      'newPassword': newPassword,
    };
  }
}

//===== Response Model =====
class ChangePasswordResponseModel extends ChangePasswordEntity {
  const ChangePasswordResponseModel({
    required super.success,
    required super.message,
  });

  factory ChangePasswordResponseModel.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
    );
  }
}