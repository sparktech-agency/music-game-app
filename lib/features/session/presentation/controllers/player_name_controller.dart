import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/session/presentation/controllers/central_session_controller/central_session_controller.dart';
import 'package:music_game_app/routes/app_routes.dart';

class PlayerNameController extends GetxController {
  final CentralSessionController sessionController = Get.find<CentralSessionController>();

  var currentTeamIndex = 0.obs;

  String get currentTeamName =>
      sessionController.teamNames.length > currentTeamIndex.value
      ? sessionController.teamNames[currentTeamIndex.value]
      : '';

  int get playerCount => sessionController.numberOfSingers.value;

  final RxList<TextEditingController> playerControllers =
      <TextEditingController>[].obs;

  @override
  void onInit() {
    super.onInit();
    _initializeControllers();
  }

  void _initializeControllers() {
    playerControllers.clear();
    for (int i = 0; i < playerCount; i++) {
      playerControllers.add(TextEditingController());
    }
  }

  Future<void> proceedToNextPage() async {
    if (playerControllers.any((c) => c.text.trim().isEmpty)) {
      Get.snackbar('Error', 'Please enter all nicknames');
      return;
    }

    List<String> currentTeamPlayers = playerControllers.map((c) => c.text.trim()).toList();

    sessionController.savePlayersForTeam(currentTeamName, currentTeamPlayers);

    // debug print--
    debugPrint("Full Team-Player Map: ${sessionController.teamPlayersMap.toJson()}");

    if (currentTeamIndex.value < sessionController.teamNames.length - 1) {
      currentTeamIndex.value++;
      _initializeControllers();
    } else {

      final bool isCreated = await sessionController.createSession();

      if (isCreated) {

        Get.toNamed(AppRoutes.spinFrontPage);
      }
    }
  }





  void clearField(TextEditingController controller) {
    controller.clear();
  }

  @override
  void onClose() {
    for (var controller in playerControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
