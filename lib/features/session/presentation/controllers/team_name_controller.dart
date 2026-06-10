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

    centralController.teamNames.value = teamNameControllers.map((c) => c.text).toList();

    print("Saved Teams: ${centralController.teamNames}");
    Get.toNamed(AppRoutes.whichTeam);

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
