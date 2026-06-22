import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/core/widgets/custom_appbar.dart';
import 'package:music_game_app/features/profile/presentation/controllers/update_nickname_controller.dart';
import 'package:music_game_app/features/profile/presentation/widgets/custom_textfield.dart';
import 'package:music_game_app/features/profile/presentation/widgets/save_button.dart';

class UpdateNicknameScreen extends StatelessWidget {
  const UpdateNicknameScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<UpdateNicknameController>();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: const CustomAppBar(
        title: 'Update My Nickname',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildCustomTextField(
                        label: 'Nickname',
                        controller: controller.nicknameController,
                      ),
                      const SizedBox(height: 12),
                    ],
                  ),
                ),
              ),
              buildSaveButton(
                onTap: () {
                  controller.updateNickname();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
