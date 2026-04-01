import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/prerequisite/presentation/controllers/prerequisite_controller.dart';

class PlayerName extends StatelessWidget {

  const PlayerName({super.key});

  @override
  Widget build(BuildContext context) {

    final PrerequisiteController controller = Get.find<PrerequisiteController>();



    return Scaffold(
      backgroundColor: const Color(0xFF050A18),
      appBar: _buildAppBar(controller),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              // //==== Subtitle: You belong on this team ====
              const SizedBox(height: 10),
              _buildTeamStatus(),
              const SizedBox(height: 20),

              Expanded(
                child: Obx(() => ListView.separated(
                  physics: const BouncingScrollPhysics(),
                  itemCount: controller.playerControllers.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 20),
                  itemBuilder: (context, index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Player ${index + 1} Nickname",
                          style: const TextStyle(color: Color(0xFF9EADDC), fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        _buildNicknameTextField(index, controller),
                      ],
                    );
                  },
                )),
              ),

              _buildNextButton(controller),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(PrerequisiteController controller) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
        onPressed: () => Get.back(),
      ),
      centerTitle: true,
      title: Obx(() {

        String currentTeamName = (controller.selectedTeam.value == 1)
            ? controller.team1Controller.text
            : controller.team2Controller.text;

        return Text(
          'Please enter the player\nnicknames for [$currentTeamName]',
          textAlign: TextAlign.center,
          style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        );
      }),
      actions: [
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 28),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }

  Widget _buildTeamStatus() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
          child: const Icon(Icons.check, size: 12, color: Colors.white),
        ),
        const SizedBox(width: 8),
        const Text(
          'You belong on this team',
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
      ],
    );
  }

  Widget _buildNicknameTextField(int index, PrerequisiteController controller) {

    return TextField(
      controller: controller.playerControllers[index],
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF101625),
        hintText: "Enter nickname",
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
        suffixIcon: IconButton(
          icon: const Icon(Icons.close, color: Colors.grey, size: 18),
          onPressed: () => controller.clearField(controller.playerControllers[index]),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF1E2746)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
      ),
    );
  }

  Widget _buildNextButton(PrerequisiteController controller) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(colors: [Color(0xFF42E8FF), Color(0xFF3B5CFF)]),
      ),
      child: ElevatedButton(
        onPressed: () => controller.proceedToNextPage("teamNickname"),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        ),
        child: const Text('Next', style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }
}