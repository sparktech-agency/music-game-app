import 'package:music_game_app/features/authentication/data/models/register_model.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_remote_source.dart';
import 'package:music_game_app/features/authentication/domain/entities/register_entity.dart';
import 'package:music_game_app/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteSource remoteSource;

  AuthRepositoryImpl(this.remoteSource);

  @override
  Future<RegisterEntity> register(String email, String password) async {

    final request = RegisterRequestModel(
      email: email,
      password: password,
    );

    final response = await remoteSource.register(request);

    return response;
  }
}