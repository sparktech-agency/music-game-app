import 'package:get/get.dart';
import 'package:music_game_app/features/session/domain/entities/create_session_entity.dart';
import 'package:music_game_app/features/session/domain/usecases/create_session_usecase.dart';

class CentralSessionController extends GetxController {
  // UseCase
  final CreateSessionUseCase _createSessionUseCase;
  CentralSessionController(this._createSessionUseCase);

  var numberOfRounds = 2.obs;
  var numberOfTeams = 2.obs;
  var numberOfSingers = 2.obs;
  var teamNames = <String>[].obs;
  var whichTeam = " ".obs;

  var preferredMusicSource = "spotify".obs;

  var teamPlayersMap = <String, List<String>>{}.obs;

  final isLoading = false.obs;
  final Rxn<CreateSessionEntity> createdSession = Rxn<CreateSessionEntity>();

  void savePlayersForTeam(String teamName, List<String> players) {
    teamPlayersMap[teamName] = players;
    print("Saved: $teamName -> $players");
  }

  Future<bool> createSession() async {
    try {
      isLoading.value = true;


      final List<Map<String, dynamic>> formattedTeams = teamPlayersMap.entries.map((entry) {
        return {
          "name": entry.key,
          "players": entry.value.map((nickname) => {"nickname": nickname}).toList(),
        };
      }).toList();


      final result = await _createSessionUseCase.call(
        totalRounds: numberOfRounds.value,
        preferredMusicSource: preferredMusicSource.value,
        teams: formattedTeams,
      );

      createdSession.value = result;
      return true;

    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString().replaceAll('Exception: ', ''),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }





}