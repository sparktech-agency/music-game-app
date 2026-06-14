import 'package:music_game_app/features/authentication/domain/entities/login_entity.dart';
import 'package:music_game_app/features/authentication/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository _repository;

  LoginUseCase(this._repository);

  Future<LoginEntity> call(String email, String password) {
    return _repository.login(email, password);
  }
}