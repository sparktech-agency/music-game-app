class RegisterEntity {
  final String id;
  final String email;
  final String role;
  final String isActive;
  final bool isVerified;
  final bool isDeleted;


  const RegisterEntity({
    required this.id,
    required this.email,
    required this.role,
    required this.isActive,
    required this.isVerified,
    required this.isDeleted,
  });
}