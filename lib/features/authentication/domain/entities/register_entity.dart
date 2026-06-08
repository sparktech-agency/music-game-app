class RegisterEntity {
  final bool success;
  final String message;
  final String? email;
  final String? role;
  final String? isActive;

  const RegisterEntity({
    required this.success,
    required this.message,
    this.email,
    this.role,
    this.isActive,
  });
}