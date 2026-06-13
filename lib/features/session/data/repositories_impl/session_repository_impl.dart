import 'package:music_game_app/features/session/data/sources/session_remote_source.dart';
import 'package:music_game_app/features/session/domain/entities/session_create_entity.dart';
import 'package:music_game_app/features/session/domain/repositories/session_repository.dart';
import 'package:music_game_app/features/session/domain/usecases/create_session_usecase.dart';

class SessionRepositoryImpl implements SessionRepository {
  final SessionRemoteSource _remoteSource;

  const SessionRepositoryImpl(this._remoteSource);


  @override
  Future<SessionCreateEntity> createSession({
    required int totalRounds,
    required String preferredMusicSource,
    required List<TeamParam> teams,
  }) async {
    try {
      final params = CreateSessionParams(
        totalRounds: totalRounds,
        preferredMusicSource: preferredMusicSource,
        teams: teams,
      );

      final responseModel = await _remoteSource.createSession(params);


      return SessionCreateEntity(
        id: responseModel.id,
        hostUserId: responseModel.hostUserId,
        totalRounds: responseModel.totalRounds,
        currentRound: responseModel.currentRound,
        status: responseModel.status,
        teams: responseModel.teams.map((t) =>
            TeamEntity(
              id: t.id,
              name: t.name,
              players: t.players
                  .map((p) => PlayerEntity(nickname: p.nickname))
                  .toList(),
              score: t.score,
            )).toList(),
        currentTeamIndex: responseModel.currentTeamIndex,
        preferredMusicSource: responseModel.preferredMusicSource,
      );
    } catch (e) {
      rethrow;
    }
  }

}


// @override
// Future<SessionEntity> startSession(String sessionId) async {
//   throw UnimplementedError();
// }
//
// @override
// Future<SessionEntity> getSessionById(String sessionId) async {
//   throw UnimplementedError();
// }
//
// @override
// Future<List<SessionEntity>> getMySessions() async {
//   throw UnimplementedError();
// }
//
// @override
// Future<SessionEntity> endSession(String sessionId) async {
//   throw UnimplementedError();
// }


