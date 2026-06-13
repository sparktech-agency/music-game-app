import 'package:music_game_app/features/session/domain/entities/session_create_entity.dart';
import 'package:music_game_app/features/session/domain/usecases/create_session_usecase.dart';

// REQUEST CLASS (UseCase Params -> JSON)

class SessionCreateRequestModel {
  final int totalRounds;
  final String preferredMusicSource;
  final List<TeamParam> teams;

  const SessionCreateRequestModel({
    required this.totalRounds,
    required this.preferredMusicSource,
    required this.teams,
  });


  factory SessionCreateRequestModel.fromParams(CreateSessionParams params) {
    return SessionCreateRequestModel(
      totalRounds: params.totalRounds,
      preferredMusicSource: params.preferredMusicSource,
      teams: params.teams,
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'totalRounds': totalRounds,
      'preferredMusicSource': preferredMusicSource,
      'teams': teams.map((team) => {
        'name': team.name,
        'players': team.players.map((player) => {
          'nickname': player.nickname,
        }).toList(),
      }).toList(),
    };
  }
}


// RESPONSE CLASS (JSON -> Entity)

class SessionCreateResponseModel extends SessionCreateEntity {
  const SessionCreateResponseModel({
    required super.id,
    required super.hostUserId,
    required super.totalRounds,
    required super.currentRound,
    required super.status,
    required super.teams,
    required super.currentTeamIndex,
    required super.preferredMusicSource,

  });


  factory SessionCreateResponseModel.fromJson(Map<String, dynamic> json) {
    return SessionCreateResponseModel(
      id: json['_id'] ?? '',
      hostUserId: json['hostUserId'] ?? '',
      totalRounds: json['totalRounds'] ?? 0,
      currentRound: json['currentRound'] ?? 0,
      status: json['status'] ?? '',
      currentTeamIndex: json['currentTeamIndex'] ?? 0,
      preferredMusicSource: json['preferredMusicSource'] ?? '',



      teams: (json['teams'] as List? ?? []).map((teamJson) {
        return TeamEntity(
          id: teamJson['_id'] ?? '',
          name: teamJson['name'] ?? '',
          score: teamJson['score'] ?? 0,
          players: (teamJson['players'] as List? ?? []).map((playerJson) {
            return PlayerEntity(
              nickname: playerJson['nickname'] ?? '',
            );
          }).toList(),
        );
      }).toList(),
    );
  }
}