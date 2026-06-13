import 'package:music_game_app/core/network/base_provider.dart';
import 'package:music_game_app/features/session/data/models/session_create_model.dart';
import 'package:music_game_app/features/session/domain/usecases/create_session_usecase.dart';

class SessionRemoteSource extends BaseProvider {

  Future<SessionCreateResponseModel> createSession(CreateSessionParams params) async {
    try {
      final requestBody = SessionCreateRequestModel.fromParams(params).toJson();

      final response = await post('/session/create', requestBody);

      if (response.isOk && response.body != null) {
        return SessionCreateResponseModel.fromJson(response.body);
      } else {
        throw Exception(response.body?['message'] ?? 'Failed to create session');
      }
    } catch (e) {
      throw Exception('Network error: ${e.toString()}');
    }
  }





  // Future<SessionResponseModel> startSession(String sessionId) async {
  //   try {
  //     final response = await post('/session/start/$sessionId', {});
  //
  //     if (response.isOk && response.body != null) {
  //       return SessionResponseModel.fromJson(response.body);
  //     } else {
  //       throw Exception(response.body?['message'] ?? 'Failed to start session');
  //     }
  //   } catch (e) {
  //     throw Exception('Network error: ${e.toString()}');
  //   }
  // }
  //
  // Future<SessionResponseModel> getSessionById(String sessionId) async {
  //   try {
  //     final response = await get('/session/$sessionId');
  //
  //     if (response.isOk && response.body != null) {
  //       return SessionResponseModel.fromJson(response.body);
  //     } else {
  //       throw Exception(response.body?['message'] ?? 'Failed to fetch session');
  //     }
  //   } catch (e) {
  //     throw Exception('Network error: ${e.toString()}');
  //   }
  // }
  //
  // Future<List<SessionResponseModel>> getMySessions() async {
  //   try {
  //     final response = await get('/session/my-sessions');
  //
  //     if (response.isOk && response.body != null) {
  //       final sessions = (response.body as List)
  //           .map((json) => SessionResponseModel.fromJson(json))
  //           .toList();
  //       return sessions;
  //     } else {
  //       throw Exception(response.body?['message'] ?? 'Failed to fetch sessions');
  //     }
  //   } catch (e) {
  //     throw Exception('Network error: ${e.toString()}');
  //   }
  // }
  //
  // Future<SessionResponseModel> endSession(String sessionId) async {
  //   try {
  //     final response = await post('/session/end/$sessionId', {});
  //
  //     if (response.isOk && response.body != null) {
  //       return SessionResponseModel.fromJson(response.body);
  //     } else {
  //       throw Exception(response.body?['message'] ?? 'Failed to end session');
  //     }
  //   } catch (e) {
  //     throw Exception('Network error: ${e.toString()}');
  //   }
  // }
}


