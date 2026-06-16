import 'package:music_game_app/features/session/domain/entities/create_session_entity.dart';


abstract class SessionRepository {

  Future<CreateSessionEntity> createSession({
    required int totalRounds,
    required String preferredMusicSource,
    required List<Map<String, dynamic>> teams,
  });
}


//Future<SessionEntity> startSession(String sessionId);
//Future<SessionEntity> getSessionById(String sessionId);
//Future<List<SessionEntity>> getMySessions();
//Future<SessionEntity> endSession(String sessionId);