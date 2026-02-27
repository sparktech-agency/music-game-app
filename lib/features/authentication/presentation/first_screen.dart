import 'package:flutter/material.dart';
import 'package:music_game_app/features/authentication/presentation/widgets/auth_button.dart';
import 'package:music_game_app/core/constants/app_constants.dart';


class FirstScreen extends StatelessWidget {
  const FirstScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.standardPadding
          ),
          child: Column(
            children: [
              const Spacer(),

              Center(child: Image.asset('assets/images/logo.png')),

              const Spacer(),

              Column(
                children: [
                  AuthButton(
                    iconPath: 'assets/images/Google.png',
                    label: 'Continue with Google',
                    onTap: () {
                      print("Google Login Tapped!");
                    },
                  ),
                  SizedBox(height: 15,),

                  AuthButton(
                    iconPath: 'assets/images/Apple.png',
                    label: 'Continue with Apple',
                    onTap: () {
                      print("Apple Login Tapped!");
                    },
                  ),
                ],
              ),
              const Spacer()
            ],
          ),
        ),
      ),
    );
  }
}
