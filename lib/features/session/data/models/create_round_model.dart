import 'package:music_game_app/features/session/domain/entities/create_round_entity.dart';


//===== Request Model =====

class CreateRoundRequestModel {
  final String sessionId;
  final int roundNumber;

  const CreateRoundRequestModel({
    required this.sessionId,
    required this.roundNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'sessionId': sessionId,
      'roundNumber': roundNumber,
    };
  }
}

//===== Response Model =====
class CreateRoundResponseModel extends CreateRoundEntity {
  const CreateRoundResponseModel({
    required super.id,
    required super.sessionId,
    required super.status,
  });

  factory CreateRoundResponseModel.fromJson(Map<String, dynamic> json) {

    final data = json['data'] as Map<String, dynamic>;

    return CreateRoundResponseModel(
      id: data['_id'] as String,
      sessionId: data['sessionId'] as String,
      status: data['status'] as String,
    );
  }
}