import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/core/common_widgets/custom_gradient_button.dart';
import 'package:music_game_app/core/widgets/custom_appbar.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/email_controller.dart';

class EmailInputPage extends StatelessWidget {
  const EmailInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    // //==== Use Get.put() or Get.find() outside the build method if using Bindings (Best Practice) ====
    // //==== For now, ensuring it's initialized only once ====
    final EmailController controller = Get.put(EmailController());

    return Scaffold(
      backgroundColor: const Color(0xFF050A18),
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(
        title: 'Log In/Register',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  // //==== Physics added to ensure smooth scrolling on all devices ====
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        'Enter Your Email Address',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),

                      // //==== TextField wrapped in a focused block for better readability ====
                      _buildEmailField(controller),
                    ],
                  ),
                ),
              ),

              // //==== Bottom section for Action Buttons ====
              _buildBottomActionArea(controller),
            ],
          ),
        ),
      ),
    );
  }

  // //==== Extracted Email Field as a method to keep build method lean and memory efficient ====
  Widget _buildEmailField(EmailController controller) {
    return TextField(
      controller: controller.emailController,
      keyboardType: TextInputType.emailAddress,
      style: const TextStyle(color: Colors.white),
      // //==== Setting textInputAction to 'next' or 'done' improves UX ====
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        hintText: 'Enter email',
        hintStyle: const TextStyle(color: Colors.grey),
        prefixIcon: const Icon(Icons.email_outlined, color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFF101625),
        contentPadding: const EdgeInsets.symmetric(vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(25),
          borderSide: const BorderSide(color: Color(0xFF1E2746)),
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

  // //==== Extracted Bottom area to avoid deep nesting ====
  Widget _buildBottomActionArea(EmailController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        CustomGradientButton(
          text: "Next",
          onPressed: () => controller.verifyEmail(),
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