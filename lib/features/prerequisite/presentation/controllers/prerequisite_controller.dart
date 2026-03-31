import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/routes/app_routes.dart';

class PrerequisiteController extends GetxController {

  // ==== Screen: Round Selection ==== //
  var numberOfRound = 3.obs;


  void selectNumberOfRound(int round) {
    numberOfRound.value = round;
  }


  final Map<int, String> _roundImages = {
    2: 'assets/images/two_player.png',
    3: 'assets/images/three_player.png',
    4: 'assets/images/four_player.png',
  };

  String get currentRoundImage => _roundImages[numberOfRound.value] ?? 'assets/images/three_player.png';


  // ==== Screen: Team Number ==== //

  var teamNumber = 2.obs;

  void selectTeamNumber(int team) {
    teamNumber.value = team;
  }

  // ==== Screen: Singer Number ==== //

  var singerNumber = 2.obs;

  void selectSingerNumber(int singer) {
    singerNumber.value = singer;
    generatePlayerFields(singer);
  }

  final Map<int, String> _singerImages = {
    2: 'assets/images/two_singer.png',
    3: 'assets/images/three_singer.png',
    4: 'assets/images/four_singer.png',
    5: 'assets/images/five_singer.png',
  };

  String get currentSingerImage => _singerImages[singerNumber.value] ?? 'assets/images/two_singer.png';



  //==== Screen: Which Team =====//

  var selectedTeam = 1.obs;

  void selectTeam(int teamNum) {
    selectedTeam.value = teamNum;
  }






  // ==== Screen: Team Names ==== //
  late TextEditingController team1Controller;
  late TextEditingController team2Controller;


  // ==== Screen: Team nickNames ==== //
  var playerControllers = <TextEditingController>[].obs;

  //==========Initialization Method========
  @override
  void onInit() {
    super.onInit();
    // //==== Initializing TextControllers once to avoid rebuild lags ====
    team1Controller = TextEditingController(text: "Team 1");
    team2Controller = TextEditingController(text: "Team 2");

    // //==== Initialize dynamic controllers based on default singerNumber ====
    generatePlayerFields(singerNumber.value);
  }

  // //==== HELPER: GENERATE DYNAMIC NICKNAME FIELDS ====
  void generatePlayerFields(int count) {
    // Dispose old controllers to avoid memory leaks
    for (var controller in playerControllers) {
      controller.dispose();
    }
    // Generate new set of controllers
    playerControllers.assignAll(
      List.generate(count, (index) => TextEditingController()),
    );
  }

// //==== CLEAR TEXT FIELD LOGIC ====
  void clearField(TextEditingController controller) {
    controller.clear();
  }



// //==== NAVIGATION & VALIDATION LOGIC ====


  void proceedToNextPage(String currentPage) {
    if (currentPage == "numberOfRounds") {
      Get.toNamed(AppRoutes.teamNumber);
    }
    else if (currentPage == "numberOfTeam") {
      Get.toNamed(AppRoutes.singerNumber);
    }
    else if(currentPage == "numberOfSinger"){
      Get.toNamed(AppRoutes.teamName);
    }

    else if(currentPage == "teamName"){
      _validateTeamNames();

    }

    else if (currentPage == "whichTeam") {
      Get.toNamed(AppRoutes.playerName);
    }

    else if(currentPage == "teamNickname"){
      _validateNicknames();

    }
  }



  void _validateTeamNames() {
    if (team1Controller.text.trim().isNotEmpty && team2Controller.text.trim().isNotEmpty) {
      Get.toNamed(AppRoutes.whichTeam);
    } else {
      _showErrorSnackbar("Team names cannot be empty");
    }
  }

  void _validateNicknames() {
    bool allFilled = playerControllers.every((c) => c.text.trim().isNotEmpty);
    if (allFilled) {
      Get.toNamed(AppRoutes.spinFrontPage);
    } else {
      _showErrorSnackbar("All player nicknames must be filled");
    }
  }

  void _showErrorSnackbar(String message) {
    Get.snackbar(
      "Required",
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent.withValues(alpha: 0.8),
      colorText: Colors.white,
      margin: const EdgeInsets.all(15),
    );
  }

  @override
  void onClose() {
    //==== CRITICAL: Dispose all controllers to prevent memory leaks ====
    team1Controller.dispose();
    team2Controller.dispose();
    for (var controller in playerControllers) {
      controller.dispose();
    }
    super.onClose();
  }
}