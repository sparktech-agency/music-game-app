import 'package:music_game_app/core/network/base_provider.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_local_source.dart';
import 'package:music_game_app/features/session/data/models/create_round_model.dart';
import 'package:music_game_app/features/session/data/models/create_session_model.dart';
import 'package:music_game_app/features/session/data/models/start_session_model.dart';

class SessionRemoteSource extends BaseProvider {



  Future<CreateSessionResponseModel> createSession(CreateSessionRequestModel request) async {
    try {
      final accessToken = AuthLocalSourceImpl().getAccessToken();
      final response = await post(
        '/session/create',
        request.toJson(),
        headers: {
          'Authorization': '$accessToken',
        },
      );

      if (response.isOk && response.body != null) {
        return CreateSessionResponseModel.fromJson(response.body);
      } else {
        final errorMessage = response.body?['message'] ?? 'Failed to create session';
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<StartSessionResponseModel> startSession(String sessionId) async {
    try {
      final accessToken = AuthLocalSourceImpl().getAccessToken();

      final response = await patch(
        '/session/$sessionId/start',
        {},
        headers: {
          'Authorization': '$accessToken',
        },
      );

      if (response.isOk && response.body != null) {
        return StartSessionResponseModel.fromJson(response.body);
      } else {
        final errorMessage = response.body?['message'] ?? 'Failed to start session';
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CreateRoundResponseModel> createRound(CreateRoundRequestModel request) async {
    try {
      final accessToken = AuthLocalSourceImpl().getAccessToken();
      final response = await post(
        '/round/create',
        request.toJson(),
        headers: {
          'Authorization': '$accessToken',
        },
      );

      if (response.isOk && response.body != null) {
        return CreateRoundResponseModel.fromJson(response.body);
      } else {
        final errorMessage = response.body?['message'] ?? 'Failed to create round';
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }
}