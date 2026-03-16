import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/password_controller.dart';


class SetPasswordPage extends StatelessWidget {
  const SetPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PasswordController controller = Get.put(PasswordController());

    return Scaffold(
      backgroundColor: const Color(0xFF050A18),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Set Password',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
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
                        controller: controller.passwordController,
                        hint: "Enter password",
                        isVisible: controller.isPasswordVisible.value,
                        onToggle: controller.togglePasswordVisibility,
                      )),

                      const SizedBox(height: 20),


                      Obx(() => _buildPasswordField(
                        controller: controller.confirmPasswordController,
                        hint: "Confirm password",
                        isVisible: controller.isConfirmPasswordVisible.value,
                        onToggle: controller.toggleConfirmPasswordVisibility,
                      )),

                      const SizedBox(height: 20),


                      const Text(
                        "The password needs 8-20 digits, containing at least letters and numbers",
                        style: TextStyle(color: Colors.white70, fontSize: 13, height: 1.4),
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


  Widget _buildNextButton(PasswordController controller) {
    return GestureDetector(
      onTap: () => controller.setPassword(),
      child: Container(
        width: double.infinity,
        height: 60,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF42E8FF), Color(0xFF3B82F6)],
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Center(
          child: Text(
            "Next",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}