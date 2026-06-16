class PlayerEntity {
  final String nickname;

  const PlayerEntity({
    required this.nickname,
  });
}

class TeamEntity {
  final String id;
  final String name;
  final List<PlayerEntity> players;
  final int score;

  const TeamEntity({
    required this.id,
    required this.name,
    required this.players,
    required this.score,
  });
}

class CreateSessionEntity {
  final String id;
  final String hostUserId;
  final int totalRounds;
  final int currentRound;
  final String status;
  final List<TeamEntity> teams;
  final int currentTeamIndex;
  final String preferredMusicSource;
  final DateTime createdAt;
  final DateTime updatedAt;

  const CreateSessionEntity({
    required this.id,
    required this.hostUserId,
    required this.totalRounds,
    required this.currentRound,
    required this.status,
    required this.teams,
    required this.currentTeamIndex,
    required this.preferredMusicSource,
    required this.createdAt,
    required this.updatedAt,
  });
}