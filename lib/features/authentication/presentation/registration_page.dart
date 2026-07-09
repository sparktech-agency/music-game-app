import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/core/common_widgets/custom_gradient_button.dart';
import 'package:music_game_app/core/widgets/custom_appbar.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/registration_controller.dart';
import 'package:music_game_app/features/authentication/presentation/widgets/custom_email_field.dart';
import 'package:music_game_app/features/authentication/presentation/widgets/custom_password_field.dart';
import 'package:music_game_app/routes/app_routes.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  // TextEditingControllers - safe lifecycle
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  late final RegistrationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<RegistrationController>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const textStyleLink = TextStyle(
      color: Colors.cyan,
      fontSize: 14,
      fontWeight: FontWeight.w600,
    );

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

                      CustomEmailField(controller: _emailController),
                      const SizedBox(height: 20),


                      Obx(() => CustomPasswordField(
                        hint: "Set your password",
                        controller: _passwordController,
                        isVisible: _controller.isPasswordVisible,
                        onToggle: _controller.togglePasswordVisibility,
                      )),
                      const SizedBox(height: 20),


                      Obx(() => CustomPasswordField(
                        hint: "Confirm your password",
                        controller: _confirmPasswordController,
                        isVisible: _controller.isConfirmPasswordVisible,
                        onToggle: _controller.toggleConfirmPasswordVisibility,
                      )),
                      const SizedBox(height: 20),


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
                            onTap: () => Get.offNamed(AppRoutes.loginPage),
                            child: const Text('Login', style: textStyleLink),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              _buildBottomActionArea(),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildBottomActionArea() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Obx(() {
          if (_controller.isLoading) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 10),
              child: CircularProgressIndicator(color: Colors.cyan),
            );
          }
          return CustomGradientButton(
            text: "Register",
            onPressed: () => _controller.register(
              _emailController.text.trim(),
              _passwordController.text.trim(),
              _confirmPasswordController.text.trim(),
            ),
          );
        }),
        const SizedBox(height: 20),
        const Text(
          'We need to verify if the email has been registered with Lyricraze',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 14),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}