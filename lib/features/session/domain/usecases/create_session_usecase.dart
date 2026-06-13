import 'package:music_game_app/features/session/domain/entities/session_create_entity.dart';
import 'package:music_game_app/features/session/domain/repositories/session_repository.dart';

class CreateSessionUseCase {
  final SessionRepository _repository;

  const CreateSessionUseCase(this._repository);


  Future<SessionCreateEntity> call(CreateSessionParams params) async {
    return await _repository.createSession(
      totalRounds: params.totalRounds,
      preferredMusicSource: params.preferredMusicSource,
      teams: params.teams,
    );
  }
}

class CreateSessionParams {
  final int totalRounds;
  final String preferredMusicSource;
  final List<TeamParam> teams;

  const CreateSessionParams({
    required this.totalRounds,
    required this.preferredMusicSource,
    required this.teams,
  });
}

class TeamParam {
  final String name;
  final List<PlayerParam> players;

  const TeamParam({
    required this.name,
    required this.players,
  });
}

class PlayerParam {
  final String nickname;

  const PlayerParam({
    required this.nickname,
  });
}