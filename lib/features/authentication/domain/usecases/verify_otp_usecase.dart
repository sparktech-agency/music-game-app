import 'package:music_game_app/features/authentication/domain/entities/verify_otp_entity.dart';
import 'package:music_game_app/features/authentication/domain/repositories/auth_repository.dart';

class VerifyOtpUseCase {
  final AuthRepository _repository;

  VerifyOtpUseCase(this._repository);

  Future<VerifyOtpEntity> call(String email, String otp) {
    return _repository.verifyOtp(email, otp);
  }
}