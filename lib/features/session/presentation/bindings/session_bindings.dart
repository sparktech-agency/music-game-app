import 'package:get/get.dart';
import 'package:music_game_app/features/session/data/repositories_impl/session_repository_impl.dart';
import 'package:music_game_app/features/session/data/sources/session_remote_source.dart';
import 'package:music_game_app/features/session/domain/repositories/session_repository.dart';
import 'package:music_game_app/features/session/domain/usecases/create_session_usecase.dart';
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



    //============== Data Source ==============
    Get.lazyPut<SessionRemoteSource>(() => SessionRemoteSource());



    //================= Repositories =================
    Get.lazyPut<SessionRepository>(
          () => SessionRepositoryImpl(Get.find<SessionRemoteSource>()),
    );


    //================= UseCases =================

    Get.lazyPut<CreateSessionUseCase>(
          () => CreateSessionUseCase(Get.find<SessionRepository>()),
    );














    //================= Controllers =================
    Get.lazyPut<CentralSessionController>(() => CentralSessionController(Get.find<CreateSessionUseCase>()), fenix: true, );

    Get.lazyPut<RoundSelectionController>(()=>RoundSelectionController());
    Get.lazyPut<TeamNumberController>(()=>TeamNumberController());
    Get.lazyPut<SingerNumberController>(()=>SingerNumberController());
    Get.lazyPut<TeamNameController>(()=>TeamNameController());
    Get.lazyPut<WhichTeamController>(()=>WhichTeamController());
    Get.lazyPut<PlayerNameController>(()=>PlayerNameController());

  }


}