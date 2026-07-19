import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/session/presentation/controllers/central_session_controller/central_session_controller.dart';
import 'package:music_game_app/routes/app_routes.dart';

class TeamNameController extends GetxController {


  final CentralSessionController centralController = Get.find<CentralSessionController>();

  late List<TextEditingController> teamNameControllers;


  @override
  void onInit() {
    super.onInit();
    int teamCount = centralController.numberOfTeams.value;
    teamNameControllers = List.generate(teamCount, (index) => TextEditingController());
  }

  void saveTeamNames() {
    // Empty field check
    bool hasEmptyField = teamNameControllers.any((controller) => controller.text.trim().isEmpty);

    if (hasEmptyField) {
      Get.snackbar(
        "Error",
        "Please enter names for all teams",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
      );
      return;
    }

    // Duplicate check
    List<String> names = teamNameControllers.map((c) => c.text.trim()).toList();
    Set<String> uniqueNames = names.toSet();

    if (uniqueNames.length != names.length) {
      Get.snackbar(
        "Error",
        "Team names must be unique",
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
        margin: const EdgeInsets.all(20),
      );
      return;
    }

    // Save if all good
    centralController.teamNames.value = names;

    
    Get.toNamed(AppRoutes.playerName);
  }



  // Clear field method
  void clearField(TextEditingController controller) {
    controller.clear();
  }


  @override
  void onClose() {
    for (var controller in teamNameControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}
