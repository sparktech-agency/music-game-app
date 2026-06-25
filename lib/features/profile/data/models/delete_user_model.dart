import 'package:music_game_app/features/profile/domain/entities/delete_user_entity.dart';

class DeleteUserResponseModel extends DeleteUserEntity {


  const DeleteUserResponseModel({
    required super.success,
    required super.message,
  });

  factory DeleteUserResponseModel.fromJson(Map<String, dynamic> json) {
    return DeleteUserResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
    );
  }
}