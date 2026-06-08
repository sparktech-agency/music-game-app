import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/core/common_widgets/custom_gradient_button.dart';
import 'package:music_game_app/core/widgets/custom_appbar.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/enter_email_controller.dart';
import 'package:music_game_app/features/authentication/presentation/widgets/custom_email_field.dart';

class EnterEmailPage extends GetView<EnterEmailController> {
  const EnterEmailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050A18),
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(title: 'Verify Email'),
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
                        'Enter Your Email',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),

                      CustomEmailField(controller: controller.emailController),

                    ],
                  ),
                ),
              ),
              CustomGradientButton(
                  text: "Get Code",
                  onPressed: ()=> controller.getCode()
              ),
              const SizedBox(height: 24)
            ],
          ),
        ),
      ),
    );
  }
}
