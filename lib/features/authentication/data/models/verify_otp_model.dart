import 'package:music_game_app/features/authentication/domain/entities/verify_otp_entity.dart';

class VerifyOtpRequestModel {
  final String email;
  final String otp;

  const VerifyOtpRequestModel({
    required this.email,
    required this.otp,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'otp': otp,
    };
  }
}

class VerifyOtpResponseModel extends VerifyOtpEntity {
  const VerifyOtpResponseModel({
    required super.accessToken,
    required super.success,
    required super.message,
  });

  factory VerifyOtpResponseModel.fromJson(Map<String, dynamic> json) {


    final data = json['data'] as Map<String, dynamic>;

    return VerifyOtpResponseModel(
      accessToken: data['accessToken'] as String,
      success: json['success'] as bool,
      message: json['message'] as String,
    );
  }
}