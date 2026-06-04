import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/core/common_widgets/custom_gradient_button.dart';
import 'package:music_game_app/core/widgets/custom_appbar.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/login_controller.dart';
import 'package:music_game_app/features/authentication/presentation/widgets/custom_email_field.dart';
import 'package:music_game_app/features/authentication/presentation/widgets/custom_password_field.dart';
import 'package:music_game_app/routes/app_routes.dart';

class LogInPage extends GetView<LoginController> {
  const LogInPage({super.key});

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
                        'Please Login',
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
                          controller: controller.passwordController,
                          isVisible: controller.isPasswordVisible.value,
                          onToggle: controller.togglePasswordVisibility
                      )),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            "Don't Have an Account? ",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          GestureDetector(
                            onTap: () {Get.toNamed(AppRoutes.registrationPage);},
                            child: const Text(
                              'Register',
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
              CustomGradientButton(
                  text: "Login",
                  onPressed: ()=> controller.login()
              ),
              const SizedBox(height: 24)
            ],
          ),
        ),
      ),
    );
  }



}
