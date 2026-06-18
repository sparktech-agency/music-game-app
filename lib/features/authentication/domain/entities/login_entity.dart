class LoginEntity {
  final String accessToken;
  final String refreshToken;
  final String id;
  final String? name;
  final String email;
  final String role;
  final String isActive;
  final bool isVerified;
  final bool isDeleted;
  final DateTime createdAt;

  const LoginEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    this.name,
    required this.email,
    required this.role,
    required this.isActive,
    required this.isVerified,
    required this.isDeleted,
    required this.createdAt,
  });
}