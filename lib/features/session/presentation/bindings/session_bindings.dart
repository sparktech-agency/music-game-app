import 'package:get/get.dart';
import 'package:music_game_app/features/game_play/presentation/controllers/game_controller.dart';
import 'package:music_game_app/features/session/presentation/controllers/central_session_controller/central_session_controller.dart';
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
    Get.lazyPut<CentralSessionController>(() => CentralSessionController(), fenix: true);
    Get.lazyPut<GameController>(() => GameController(), fenix: true);

    Get.lazyPut<RoundSelectionController>(()=>RoundSelectionController());
    Get.lazyPut<TeamNumberController>(()=>TeamNumberController());
    Get.lazyPut<SingerNumberController>(()=>SingerNumberController());
    Get.lazyPut<TeamNameController>(()=>TeamNameController());
    Get.lazyPut<WhichTeamController>(()=>WhichTeamController());
    Get.lazyPut<PlayerNameController>(()=>PlayerNameController());

  }


}