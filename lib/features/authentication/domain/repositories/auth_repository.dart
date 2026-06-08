import 'package:music_game_app/features/authentication/domain/entities/register_entity.dart';

abstract class AuthRepository {

  Future<RegisterEntity> register(String email, String password);

}