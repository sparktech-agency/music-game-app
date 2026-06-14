import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/core/common_widgets/custom_gradient_button.dart';
import 'package:music_game_app/core/widgets/custom_appbar.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/login_controller.dart';
import 'package:music_game_app/features/authentication/presentation/widgets/custom_email_field.dart';
import 'package:music_game_app/features/authentication/presentation/widgets/custom_password_field.dart';
import 'package:music_game_app/routes/app_routes.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  // TextEditingControllers live here — safe lifecycle
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  late final LoginController _controller;

  @override
  void initState() {
    super.initState();
    _controller = Get.find<LoginController>();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

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

                      CustomEmailField(controller: _emailController),
                      const SizedBox(height: 20),

                      Obx(() => CustomPasswordField(
                        controller: _passwordController,
                        isVisible: _controller.isPasswordVisible.value,
                        onToggle: _controller.togglePasswordVisibility,
                      )),

                      const SizedBox(height: 10),

                      Align(
                        alignment: Alignment.centerRight,
                        child: GestureDetector(
                          onTap: () => Get.toNamed(AppRoutes.enterEmailPage),
                          child: const Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

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
                            onTap: () =>
                                Get.toNamed(AppRoutes.registrationPage),
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
              Obx(() => _controller.isLoading.value
                  ? const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: CircularProgressIndicator(color: Colors.cyan),
              )
                  : CustomGradientButton(
                text: "Login",
                onPressed: () => _controller.login(
                  _emailController.text.trim(),
                  _passwordController.text.trim(),
                ),
              )),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}