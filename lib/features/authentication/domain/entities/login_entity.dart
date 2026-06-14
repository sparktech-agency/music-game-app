class LoginEntity {
  final String accessToken;
  final String refreshToken;
  final String id;
  final String email;
  final String role;

  const LoginEntity({
    required this.accessToken,
    required this.refreshToken,
    required this.id,
    required this.email,
    required this.role,
  });
}