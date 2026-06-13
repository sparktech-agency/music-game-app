import 'package:music_game_app/features/session/domain/entities/session_create_entity.dart';
import 'package:music_game_app/features/session/domain/usecases/create_session_usecase.dart';

abstract class SessionRepository {

  Future<SessionCreateEntity> createSession({
    required int totalRounds,
    required String preferredMusicSource,
    required List<TeamParam> teams,
  });


//Future<SessionEntity> startSession(String sessionId);
//Future<SessionEntity> getSessionById(String sessionId);
//Future<List<SessionEntity>> getMySessions();
//Future<SessionEntity> endSession(String sessionId);
}