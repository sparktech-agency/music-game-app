

import 'package:flutter/material.dart';
import 'package:music_game_app/core/widgets/custom_appbar.dart';
import 'package:music_game_app/features/profile/presentation/widgets/save_button.dart';

class UpdateProfilePictureScreen extends StatelessWidget {
  const UpdateProfilePictureScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: CustomAppBar(
        title: 'Update Profile Picture',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [

                      Container(
                        width: 210,
                        height: 210,
                        decoration: const BoxDecoration(
                          color: Color(0xFF193B46),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.person,
                          size: 110,
                          color: Colors.white24,
                        ),
                      ),

                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          width: 58,
                          height: 58,
                          decoration: const BoxDecoration(
                            color: Color(0xFF338DFF),
                            shape: BoxShape.circle,
                          ),
                          padding: const EdgeInsets.all(3),
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: const Stack(
                              alignment: Alignment.center,
                              children: [
                                Icon(
                                  Icons.cloud_outlined,
                                  color: Colors.grey,
                                  size: 28,
                                ),
                                Positioned(
                                  bottom: 17,
                                  child: Icon(
                                    Icons.arrow_upward,
                                    color: Colors.redAccent,
                                    size: 14,
                                    weight: 3.0,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              buildSaveButton(
                onTap: () {
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}