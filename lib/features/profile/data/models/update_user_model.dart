import 'dart:convert';
import 'package:music_game_app/features/profile/domain/entities/update_user_entity.dart';


//===== Request Model =====

class UpdateUserRequestModel {
  final String firstName;
  final String lastName;
  final String nickName;
  final String? profilePath;

  const UpdateUserRequestModel({
    required this.firstName,
    required this.lastName,
    required this.nickName,
    this.profilePath,
  });


  String toDataJsonString() {
    return jsonEncode({
      'firstName': firstName,
      'lastName': lastName,
      'nickName': nickName,
    });
  }
}

//===== Response Model =====
class UpdateUserResponseModel extends UpdateUserEntity {
  const UpdateUserResponseModel({
    required super.id,
    required super.email,
    required super.isActive,
    required super.isVerified,
    required super.firstName,
    required super.lastName,
    required super.nickName,
    required super.createdAt,
  });

  factory UpdateUserResponseModel.fromJson(Map<String, dynamic> json) {

    final data = json['data'] as Map<String, dynamic>;

    return UpdateUserResponseModel(
      id: data['_id'] as String,
      email: data['email'] as String,
      isActive: data['isActive'] as String,
      isVerified: data['isVerified'] as bool,
      firstName: data['firstName'] as String,
      lastName: data['lastName'] as String,
      nickName: data['nickName'] as String,
      createdAt: DateTime.parse(data['createdAt'] as String),
    );
  }
}