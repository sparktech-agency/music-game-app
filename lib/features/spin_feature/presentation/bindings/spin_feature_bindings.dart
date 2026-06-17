import 'package:get/get.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/turn_management/turn_management_controller.dart';

class SpinFeatureBindings extends Bindings{

  @override
  void dependencies() {



    //========= Controllers =========
    Get.lazyPut<TurnManagementController>(() => TurnManagementController(), fenix: true);


  }
}