class LoginEntity {
  final String accessToken;
  final String refreshToken;
  final String id;
  final String email;
  final String role;
  final bool isVerified;
  final String firstName;
  final String lastName;
  final String nickName;
  final String? profile;
  final DateTime createdAt;

  const LoginEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.email,
    required this.role,
    required this.isVerified,
    required this.firstName,
    required this.lastName,
    required this.nickName,
    this.profile,
    required this.createdAt,
  });
}