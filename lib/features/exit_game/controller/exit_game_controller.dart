import 'package:get/get.dart';
import 'package:music_game_app/features/session/presentation/controllers/central_session_controller/central_session_controller.dart';
import 'package:music_game_app/features/spin_feature/presentation/controllers/turn_management/turn_management_controller.dart';
import 'package:music_game_app/routes/app_routes.dart';

class ExitGameController extends GetxController {

  var isLoading = false.obs;

  Future<void> handleExit() async {
    try {
      isLoading.value = true;

      Get.back(); 

      Get.delete<TurnManagementController>(force: true);

      
      if (Get.isRegistered<CentralSessionController>()) {
        Get.find<CentralSessionController>().resetSessionData();
      }

      
      Get.offAllNamed(AppRoutes.appLanding);

    } catch (e) {
  
      print("Error during exit: $e");
    } finally {
      isLoading.value = false;
    }
  }

  void handleCancel() {
    Get.back(); 
  }
}