import 'package:music_game_app/features/authentication/domain/entities/register_entity.dart';
import 'package:music_game_app/features/authentication/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  Future<RegisterEntity> call(String email, String password) {
    return repository.register(email, password);
  }
}