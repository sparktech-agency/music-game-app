class UpdateUserEntity {
  final String id;
  final String email;
  final bool isVerified;
  final String firstName;
  final String lastName;
  final String nickName;
  final String? profile;


  const UpdateUserEntity({
    required this.id,
    required this.email,
    required this.isVerified,
    required this.firstName,
    required this.lastName,
    required this.nickName,
    this.profile,
  });
}