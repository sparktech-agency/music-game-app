class UpdateUserEntity {
  final String id;
  final String email;
  final String isActive;
  final bool isVerified;
  final String firstName;
  final String lastName;
  final String nickName;
  final DateTime createdAt;

  const UpdateUserEntity({
    required this.id,
    required this.email,
    required this.isActive,
    required this.isVerified,
    required this.firstName,
    required this.lastName,
    required this.nickName,
    required this.createdAt,
  });
}