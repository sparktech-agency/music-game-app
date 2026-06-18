import 'package:music_game_app/features/authentication/domain/entities/forgot_password_entity.dart';
import 'package:music_game_app/features/authentication/domain/repositories/auth_repository.dart';

class ForgotPasswordUseCase {
  final AuthRepository _repository;

  ForgotPasswordUseCase(this._repository);

  Future<ForgotPasswordEntity> call(String email) {
    return _repository.forgotPassword(email);
  }
}