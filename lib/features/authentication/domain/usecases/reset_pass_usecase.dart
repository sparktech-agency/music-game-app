import 'package:music_game_app/features/authentication/domain/entities/reset_pass_entity.dart';
import 'package:music_game_app/features/authentication/domain/repositories/auth_repository.dart';

class ResetPassUseCase {
  final AuthRepository _repository;

  ResetPassUseCase(this._repository);

  Future<ResetPassEntity> call({
    required String email,
    required String newPass,
    required String confirmNewPass,
  }) {
    return _repository.resetPassword(
      email: email,
      newPass: newPass,
      confirmNewPass: confirmNewPass,
    );
  }
}