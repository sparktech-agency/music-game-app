import 'package:music_game_app/features/session/domain/entities/create_session_entity.dart';




//===== Player Model =====

class PlayerModel extends PlayerEntity {
  const PlayerModel({required super.nickname});

  factory PlayerModel.fromJson(Map<String, dynamic> json) {
    return PlayerModel(
      nickname: json['nickname'] as String,
    );
  }
}

//===== Team Model =====
class TeamModel extends TeamEntity {
  const TeamModel({
    required super.id,
    required super.name,
    required super.players,
    required super.score,
  });

  factory TeamModel.fromJson(Map<String, dynamic> json) {
    final playersList = json['players'] as List<dynamic>;
    return TeamModel(
      id: json['_id'] as String,
      name: json['name'] as String,
      players: playersList
          .map((p) => PlayerModel.fromJson(p as Map<String, dynamic>))
          .toList(),
      score: json['score'] as int,
    );
  }
}

//===== Response Model =====
class CreateSessionResponseModel extends CreateSessionEntity {
  const CreateSessionResponseModel({
    required super.id,
    required super.hostUserId,
    required super.totalRounds,
    required super.currentRound,
    required super.status,
    required super.teams,
    required super.currentTeamIndex,
    required super.preferredMusicSource,
    required super.createdAt,
    required super.updatedAt,
  });

  factory CreateSessionResponseModel.fromJson(Map<String, dynamic> json) {
    final data = json['data'] as Map<String, dynamic>;
    final teamsList = data['teams'] as List<dynamic>;

    return CreateSessionResponseModel(
      id: data['_id'] as String,
      hostUserId: data['hostUserId'] as String,
      totalRounds: data['totalRounds'] as int,
      currentRound: data['currentRound'] as int,
      status: data['status'] as String,
      teams: teamsList
          .map((t) => TeamModel.fromJson(t as Map<String, dynamic>))
          .toList(),
      currentTeamIndex: data['currentTeamIndex'] as int,
      preferredMusicSource: data['preferredMusicSource'] as String,
      createdAt: DateTime.parse(data['createdAt'] as String),
      updatedAt: DateTime.parse(data['updatedAt'] as String),
    );
  }
}

//===== Request Model =====
class CreateSessionRequestModel {
  final int totalRounds;
  final String preferredMusicSource;
  final List<Map<String, dynamic>> teams;

  const CreateSessionRequestModel({
    required this.totalRounds,
    required this.preferredMusicSource,
    required this.teams,
  });

  Map<String, dynamic> toJson() {
    return {
      'totalRounds': totalRounds,
      'preferredMusicSource': preferredMusicSource,
      'teams': teams,
    };
  }
}