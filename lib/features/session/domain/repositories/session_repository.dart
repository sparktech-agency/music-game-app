import 'package:music_game_app/features/session/domain/entities/create_round_entity.dart';
import 'package:music_game_app/features/session/domain/entities/create_session_entity.dart';
import 'package:music_game_app/features/session/domain/entities/start_session_entity.dart';


abstract class SessionRepository {

  Future<CreateSessionEntity> createSession({
    required int totalRounds,
    required String preferredMusicSource,
    required List<Map<String, dynamic>> teams,
  });


  Future<StartSessionEntity> startSession(String sessionId);

  Future<CreateRoundEntity> createRound({
    required String sessionId,
    required int roundNumber,
  });
}




//Future<SessionEntity> startSession(String sessionId);
//Future<SessionEntity> endSession(String sessionId);