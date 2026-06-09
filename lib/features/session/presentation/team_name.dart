import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/session/presentation/controllers/team_name_controller.dart';


class TeamName extends GetView<TeamNameController> {
  const TeamName({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21), // Dark Navy Background
      appBar: _buildAppBar(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      _buildInputLabel("Team 1 Name"),
                      const SizedBox(height: 10),
                      _buildTeamTextField(
                        controller.team1Controller,
                        controller,
                      ),

                      const SizedBox(height: 25),

                      _buildInputLabel("Team 2 Name"),
                      const SizedBox(height: 10),
                      _buildTeamTextField(
                        controller.team2Controller,
                        controller,
                      ),
                    ],
                  ),
                ),
              ),
              _buildNextButton(controller),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // //==== Custom AppBar for the design ====
  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Colors.white,
          size: 20,
        ),
        onPressed: () => Get.back(),
      ),
      centerTitle: true,
      title: const Text(
        'Please enter the team\nnames on each team',
        textAlign: TextAlign.center,
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.close, color: Colors.white, size: 28),
          onPressed: () => Get.back(),
        ),
      ],
    );
  }

  Widget _buildInputLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        color: Color(0xFF9EADDC),
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // //==== Optimized TextField with Clear functionality ====
  Widget _buildTeamTextField(
    TextEditingController textController,
    TeamNameController controller,
  ) {
    return TextField(
      controller: textController,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF161B2E),
        suffixIcon: IconButton(
          icon: const Icon(Icons.cancel, color: Colors.grey, size: 20),
          onPressed: () => controller.clearField(textController),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color(0xFF242C4B)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.blueAccent, width: 1.5),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 18,
        ),
      ),
    );
  }

  // //==== Pixel Perfect Gradient Button ====
  Widget _buildNextButton(TeamNameController controller) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF42E8FF), // Cyan
            Color(0xFF3B5CFF), // Blue
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: ElevatedButton(
        onPressed: () => controller.proceedToNextPage(),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'Next',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
