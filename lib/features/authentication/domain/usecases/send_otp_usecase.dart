import 'package:music_game_app/features/authentication/domain/entities/send_otp_entity.dart';
import 'package:music_game_app/features/authentication/domain/repositories/auth_repository.dart';

class SendOtpUseCase {
  final AuthRepository _repository;

  SendOtpUseCase(this._repository);

  Future<SendOtpEntity> call(String email) {
    return _repository.sendOtp(email);
  }
}