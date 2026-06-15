import 'package:music_game_app/features/authentication/domain/entities/send_otp_entity.dart';

class SendOtpRequestModel {
  final String email;

  const SendOtpRequestModel({
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
    };
  }
}

class SendOtpResponseModel extends SendOtpEntity {
  const SendOtpResponseModel({
    required super.success,
    required super.message,
  });

  factory SendOtpResponseModel.fromJson(Map<String, dynamic> json) {
    return SendOtpResponseModel(
      success: json['success'] as bool,
      message: json['message'] as String,
    );
  }
}