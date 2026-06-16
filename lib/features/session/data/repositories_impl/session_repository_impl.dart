import 'package:music_game_app/features/session/data/models/create_session_model.dart';
import 'package:music_game_app/features/session/data/sources/session_remote_source.dart';
import 'package:music_game_app/features/session/domain/entities/create_session_entity.dart';
import 'package:music_game_app/features/session/domain/repositories/session_repository.dart';

class SessionRepositoryImpl implements SessionRepository {
  final SessionRemoteSource _remoteSource;

  SessionRepositoryImpl(this._remoteSource);

  @override
  Future<CreateSessionEntity> createSession({
    required int totalRounds,
    required String preferredMusicSource,
    required List<Map<String, dynamic>> teams,
  }) async {

    final request = CreateSessionRequestModel(
      totalRounds: totalRounds,
      preferredMusicSource: preferredMusicSource,
      teams: teams,
    );


    final response = await _remoteSource.createSession(request);

    return response;
  }
}