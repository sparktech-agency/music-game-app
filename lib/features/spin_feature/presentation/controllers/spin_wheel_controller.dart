import 'package:get/get.dart';

class SpinWheelController extends GetxController {
  // //==== Observables ====
  var isSpinning = false.obs;
  var hasSpun = false.obs;
  var resultText = "spin".obs;

  // //==== Update Result Method ====
  void updateResult(String category) {
    resultText.value = category;
    hasSpun.value = true;
    isSpinning.value = false;
  }

  // //==== Reset Method (If needed for next round) ====
  void resetSpin() {
    hasSpun.value = false;
    resultText.value = "spin";
  }
}