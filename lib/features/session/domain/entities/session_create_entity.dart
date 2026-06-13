

class SessionCreateEntity {
  final String id;
  final String hostUserId;
  final int totalRounds;
  final int currentRound;
  final String status;
  final List<TeamEntity> teams;
  final int currentTeamIndex;
  final String preferredMusicSource;


  const SessionCreateEntity({
    required this.id,
    required this.hostUserId,
    required this.totalRounds,
    required this.currentRound,
    required this.status,
    required this.teams,
    required this.currentTeamIndex,
    required this.preferredMusicSource,

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

class PlayerEntity {
  final String nickname;

  const PlayerEntity({
    required this.nickname,
  });
}