import 'package:get/get.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/turn_management/turn_management_controller.dart';

class SpinWheelController extends GetxController {



  var isSpinning = false.obs;
  var hasSpun = false.obs;
  var resultText = "spin".obs;


  late final TurnManagementController _turnController;


  @override
  void onInit() {
    super.onInit();
    _turnController = Get.find<TurnManagementController>();
  }




  void updateResult(String category) {
    resultText.value = category;
    hasSpun.value = true;
    isSpinning.value = false;

    _turnController.pickSongFromDatabase(category);
  }



  //==== Reset Method (If needed for next round) ====

  void resetSpin() {
    hasSpun.value = false;
    resultText.value = "spin";
    isSpinning.value = false;
  }
}