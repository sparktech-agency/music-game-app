import 'package:get/get.dart';
import 'package:music_game_app/features/session/presentation/controllers/player_name_controller.dart';
import 'package:music_game_app/features/session/presentation/controllers/round_selection_controller.dart';
import 'package:music_game_app/features/session/presentation/controllers/singer_number_controller.dart';
import 'package:music_game_app/features/session/presentation/controllers/team_name_controller.dart';
import 'package:music_game_app/features/session/presentation/controllers/team_number_controller.dart';
import 'package:music_game_app/features/session/presentation/controllers/which_team_controller.dart';

class SessionBindings extends Bindings{

  @override
  void dependencies() {


    //================= Controllers =================


    Get.lazyPut<RoundSelectionController>(()=>RoundSelectionController());
    Get.lazyPut<TeamNumberController>(()=>TeamNumberController());
    Get.lazyPut<SingerNumberController>(()=>SingerNumberController());
    Get.lazyPut<TeamNameController>(()=>TeamNameController());
    Get.lazyPut<WhichTeamController>(()=>WhichTeamController());
    Get.lazyPut<PlayerNameController>(()=>PlayerNameController());

  }


}