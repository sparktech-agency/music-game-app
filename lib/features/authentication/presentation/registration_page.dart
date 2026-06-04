import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/core/common_widgets/custom_gradient_button.dart';
import 'package:music_game_app/core/widgets/custom_appbar.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/registration_controller.dart';
import 'package:music_game_app/features/authentication/presentation/widgets/custom_email_field.dart';
import 'package:music_game_app/features/authentication/presentation/widgets/custom_password_field.dart';
import 'package:music_game_app/routes/app_routes.dart';

class RegistrationPage extends GetView<RegistrationController> {
  const RegistrationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050A18),
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(title: 'Log In/Register'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        'Register with Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      CustomEmailField(controller: controller.emailController),

                      const SizedBox(height: 20),

                      Obx(() => CustomPasswordField(
                          hint: "Set your password",
                          controller: controller.passwordController,
                          isVisible: controller.isPasswordVisible.value,
                          onToggle: controller.togglePasswordVisibility
                      )),

                      const SizedBox(height: 20),

                      Obx(() => CustomPasswordField(
                          hint: "Confirm your password",
                          controller: controller.confirmPasswordController,
                          isVisible: controller.isConfirmPasswordVisible.value,
                          onToggle: controller.toggleConfirmPasswordVisibility
                      )),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Already have an Account? ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {Get.offNamed(AppRoutes.loginPage);},
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                color: Colors.cyan,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
             _buildBottomActionArea(controller)
            ],
          ),
        ),
      ),
    );
  }
















  Widget _buildBottomActionArea(RegistrationController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomGradientButton(
          text: "Register",
          onPressed: () => controller.register(),
        ),
        const SizedBox(height: 20),
        const Text(
          'We need to verify if the email has been registered with Lyricraze',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.grey,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
