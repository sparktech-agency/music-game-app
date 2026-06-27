import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/core/widgets/custom_appbar.dart';
import 'package:music_game_app/features/profile/presentation/controllers/change_password_controller.dart';

class ChangePasswordScreen extends GetView<ChangePasswordController> {
  const ChangePasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050A18),


      appBar: const CustomAppBar(title: 'Change Password'),



      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),

                      Obx(() => _buildPasswordField(
                        controller: controller.currentPasswordController,
                        hint: "Enter current password",
                        isVisible: controller.isCurrentPasswordVisible.value,
                        onToggle: controller.togglePasswordVisibility,
                      )),

                      const SizedBox(height: 20),

                      Obx(() => _buildPasswordField(
                        controller: controller.newPasswordController,
                        hint: "Enter new password",
                        isVisible: controller.isNewPasswordVisible.value,
                        onToggle: controller.toggleConfirmPasswordVisibility,
                      )),

                      const SizedBox(height: 20),

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

  Widget _buildPasswordField({
    required TextEditingController controller,
    required String hint,
    required bool isVisible,
    required VoidCallback onToggle,
  }) {
    return TextField(
      controller: controller,
      obscureText: !isVisible,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
        filled: true,
        fillColor: const Color(0xFF101625),
        contentPadding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        suffixIcon: IconButton(
          icon: Icon(
            isVisible ? Icons.visibility : Icons.visibility_off_outlined,
            color: Colors.grey,
            size: 20,
          ),
          onPressed: onToggle,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Color(0xFF1E2746)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Colors.blueAccent),
        ),
      ),
    );
  }

  Widget _buildNextButton(ChangePasswordController controller) {
    return Obx(() => GestureDetector(
      onTap: controller.isLoading.value
          ? null
          : () => controller.changePassword(),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF42E8FF), Color(0xFF3B82F6)],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Center(
          child: Text(
            controller.isLoading.value ? "Saving..." : "Save",
            style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    ));
  }
}