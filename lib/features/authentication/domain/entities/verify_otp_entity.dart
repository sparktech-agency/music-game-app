class VerifyOtpEntity {
  final String accessToken;
  final bool success;
  final String message;

  const VerifyOtpEntity({
    required this.accessToken,
    required this.success,
    required this.message,
  });
}