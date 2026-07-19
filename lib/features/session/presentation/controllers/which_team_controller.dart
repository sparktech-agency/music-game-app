import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/session/presentation/controllers/central_session_controller/central_session_controller.dart';
import 'package:music_game_app/routes/app_routes.dart';

class WhichTeamController extends GetxController {
  final CentralSessionController sessionController = Get.find<CentralSessionController>();

  List<String> get teamNames => sessionController.teamNames;

  var isSwapped = false.obs;

  void selectTeam(String teamName) {
    sessionController.whichTeam.value = teamName;

    isSwapped.toggle();
  }

  bool isSelected(String teamName) {
    return sessionController.whichTeam.value == teamName;
  }

  void proceedToNextPage() {
    if (sessionController.whichTeam.value.trim().isEmpty) {
      Get.snackbar(
        'Warning',
        'Please select a team first',
        snackPosition: SnackPosition.TOP,
        colorText: Colors.black,
        backgroundColor: Color(0xFF42E8FF),
      );
      return;
    }

    
    Get.toNamed(AppRoutes.spinFrontPage);
  }
}