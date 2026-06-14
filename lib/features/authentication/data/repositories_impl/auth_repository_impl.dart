import 'package:music_game_app/features/authentication/data/models/login_model.dart';
import 'package:music_game_app/features/authentication/data/models/register_model.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_remote_source.dart';
import 'package:music_game_app/features/authentication/domain/entities/login_entity.dart';
import 'package:music_game_app/features/authentication/domain/entities/register_entity.dart';
import 'package:music_game_app/features/authentication/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteSource _remoteSource;

  AuthRepositoryImpl(this._remoteSource);

  @override
  Future<RegisterEntity> register(String email, String password) async {

    final request = RegisterRequestModel(
      email: email,
      password: password,
    );

    final response = await _remoteSource.register(request);

    return response;
  }

  @override
  Future<LoginEntity> login(String email, String password) async {
    final request = LoginRequestModel(
      email: email,
      password: password,
    );

    final response = await _remoteSource.login(request);

    return response;
  }
}