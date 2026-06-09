import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class TeamNameController extends GetxController {

  final TextEditingController team1Controller = TextEditingController();
  final TextEditingController team2Controller = TextEditingController();

  // Clear field method
  void clearField(TextEditingController controller) {
    controller.clear();
  }

  // Proceed to next page
  void proceedToNextPage() {
   print("Team name completed");
   Get.toNamed(AppRoutes.whichTeam);

  }

  @override
  void onClose() {

    team1Controller.dispose();
    team2Controller.dispose();
    super.onClose();
  }
}
