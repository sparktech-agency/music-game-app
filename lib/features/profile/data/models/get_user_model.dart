import '../../domain/entities/get_user_entity.dart';

class GetUserResponseModel extends GetUserEntity {
  const GetUserResponseModel({
    required super.id,
    required super.email,
    required super.isVerified,
    super.firstName,
    super.lastName,
    super.nickName,
    super.profile,
    required super.createdAt,
  });

  factory GetUserResponseModel.fromJson(Map<String, dynamic> json) {

    final data = json['data'] as Map<String, dynamic>;

    return GetUserResponseModel(
      id: data['_id'] as String,
      email: data['email'] as String,
      isVerified: data['isVerified'] as bool? ?? false,
      firstName: data['firstName'] ?? "Unknown",
      lastName: data['lastName'] ?? "",
      nickName: data['nickName'] ?? "user" ,
      profile: data['profile'] as String?,
      createdAt: DateTime.parse(data['createdAt'] as String),
    );
  }
}