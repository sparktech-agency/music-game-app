import 'package:music_game_app/features/session/domain/entities/start_session_entity.dart';

class StartSessionResponseModel extends StartSessionEntity {
  const StartSessionResponseModel({
    required super.id,
    required super.status,
  });

  factory StartSessionResponseModel.fromJson(Map<String, dynamic> json) {

    final data = json['data'] as Map<String, dynamic>;

    return StartSessionResponseModel(
      id: data['_id'] as String,
      status: data['status'] as String,
    );
  }
}