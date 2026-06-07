import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:music_game_app/core/widgets/custom_appbar.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/verify_phone_controller.dart';
import 'package:pinput/pinput.dart';

class VerifyPhonePage extends GetView<VerifyPhoneController> {
  const VerifyPhonePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF050A18),
      resizeToAvoidBottomInset: true,
      appBar: const CustomAppBar(title: 'Verify Number'),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 40),

              SvgPicture.asset(
                'assets/images/verify_code_icon.svg',
                width: 80,
                height: 80,
              ),
              const SizedBox(height: 40),

              const Text(
                "Lyricraze Has Sent a Code to Your Phone\nPlease allow up to 3 minutes for it to arrive, then enter it below.",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              const SizedBox(height: 30),

              // Circle OTP Input
              Pinput(
                  length: 4,
                  defaultPinTheme: defaultPinTheme,
                  keyboardType: TextInputType.number, // only number keyboard
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly, // only digits allowed
                  ],
                  onCompleted: (pin) {} //controller.verifyCode(pin),
              ),

              const SizedBox(height: 20),
              GestureDetector(
                onTap: (){},//controller.resendCode,
                child: Text.rich(
                  TextSpan(
                    style: const TextStyle(color: Colors.white, fontSize: 14), // base style (no bold)
                    children: const [
                      TextSpan(text: "Didn't get a code? "),
                      TextSpan(
                        text: "Resend a code",
                        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.cyan,), // bold only this part
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Circle Pin Theme
final defaultPinTheme = PinTheme(
  width: 56,
  height: 56,
  textStyle: const TextStyle(
    fontSize: 24,
    color: Colors.white,
    fontWeight: FontWeight.bold,
  ),
  decoration: BoxDecoration(
    shape: BoxShape.circle,
    color: Color(0xFF101625),
    border: Border.all(
      color: Colors.cyan,
      width: 1,
    ),
  ),
);
