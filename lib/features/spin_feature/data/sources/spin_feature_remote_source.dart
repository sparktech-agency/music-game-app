import 'package:music_game_app/core/network/base_provider.dart';
import 'package:music_game_app/features/authentication/data/sources/auth_local_source.dart';
import 'package:music_game_app/features/spin_feature/data/models/get_song_model.dart';

class SpinFeatureRemoteSource extends BaseProvider {

  Future<GetSongResponseModel> getSong({
    required String roundId,
    required int turnIndex,
    required GetSongRequestModel request,
  }) async {
    try {

      final accessToken = AuthLocalSourceImpl().getAccessToken();

      final response = await post(
        '/round/$roundId/turn/$turnIndex/spin',
        request.toJson(),
        headers: {
          'Authorization': '$accessToken',
        },
      );

      if (response.isOk && response.body != null) {
        return GetSongResponseModel.fromJson(response.body);
      } else {
        final errorMessage = response.body?['message'] ?? 'Failed to get song';
        throw Exception(errorMessage);
      }
    } catch (e) {
      rethrow;
    }
  }
}