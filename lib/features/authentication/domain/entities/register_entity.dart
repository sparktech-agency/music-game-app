class RegisterEntity {
  final String id;
  final String email;
  final String? name;
  final String role;
  final String isActive;
  final bool isVerified;
  final bool isDeleted;
  final DateTime createdAt;


  const RegisterEntity({
    required this.id,
    required this.email,
    this.name,
    required this.role,
    required this.isActive,
    required this.isVerified,
    required this.isDeleted,
    required this.createdAt
  });
}