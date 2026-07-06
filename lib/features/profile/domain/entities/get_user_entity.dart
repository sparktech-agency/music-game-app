class GetUserEntity {
  final String id;
  final String email;
  final bool isVerified;
  final String? firstName;
  final String? lastName;
  final String? nickName;
  final String? profile;
  final DateTime createdAt;


  const GetUserEntity({
    required this.id,
    required this.email,
    required this.isVerified,
    this.firstName,
    this.lastName,
    this.nickName,
    this.profile,
    required this.createdAt,
  });
}