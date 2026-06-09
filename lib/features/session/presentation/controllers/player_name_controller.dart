import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PlayerNameController extends GetxController {

  //arguments from previous screen

  late final String teamName;
  late final int playerCount;


  final RxList<TextEditingController> playerControllers = <TextEditingController>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadArguments();
    _initializePlayerControllers();
  }


  void _loadArguments() {

    teamName = Get.arguments?['teamName'] ?? 'Unknown Team';
    playerCount = Get.arguments?['playerCount'] ?? 2;
  }


  void _initializePlayerControllers() {
    for (int i = 0; i < playerCount; i++) {
      playerControllers.add(TextEditingController());
    }
  }


  void clearField(TextEditingController controller) {
    controller.clear();
  }


  void proceedToNextPage() {

    for (var controller in playerControllers) {
      if (controller.text.trim().isEmpty) {
        Get.snackbar(
          'Error',
          'Please enter nicknames for all players',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
        return;
      }
    }


    List<String> playerNames = playerControllers.map((c) => c.text.trim()).toList();


    // Get.toNamed('/gameScreen', arguments: {
    //   'teamName': teamName,
    //   'players': playerNames,
    // });

    print("Team: $teamName, Players: $playerNames");
  }

  @override
  void onClose() {
    for (var controller in playerControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}