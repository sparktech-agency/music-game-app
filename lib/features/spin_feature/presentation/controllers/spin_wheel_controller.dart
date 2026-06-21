import 'package:get/get.dart';

class SpinWheelController extends GetxController {
  var isSpinning = false.obs;
  var hasSpun = false.obs;
  var resultText = "spin".obs;

  void updateResult(String category) {
    resultText.value = category;
    hasSpun.value = true;
    isSpinning.value = false;
  }

  void resetSpin() {
    hasSpun.value = false;
    resultText.value = "spin";
    isSpinning.value = false;
  }
}