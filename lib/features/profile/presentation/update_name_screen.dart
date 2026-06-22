import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/core/widgets/custom_appbar.dart';
import 'package:music_game_app/features/profile/presentation/controllers/update_name_controller.dart';
import 'package:music_game_app/features/profile/presentation/widgets/custom_textfield.dart';
import 'package:music_game_app/features/profile/presentation/widgets/save_button.dart';


class UpdateNameScreen extends StatelessWidget {
  const UpdateNameScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<UpdateNameController>();

    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: const CustomAppBar(
        title: 'Update My Name',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [

                      buildCustomTextField(
                        label: 'First Name',
                        controller: controller.firstNameController,
                        hintText: controller.firstNameController.text,
                      ),
                      const SizedBox(height: 20),

                      buildCustomTextField(
                        label: 'Last Name',
                        controller: controller.lastNameController,
                        hintText: controller.firstNameController.text,
                      ),
                    ],
                  ),
                ),
              ),

              Obx(() {
                return controller.isLoading.value
                    ? const CircularProgressIndicator(color: Colors.white)
                    : buildSaveButton(
                  onTap: () {
                    controller.updateName();
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}