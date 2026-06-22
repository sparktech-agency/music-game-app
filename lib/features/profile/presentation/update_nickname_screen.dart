import 'package:flutter/material.dart';
import 'package:music_game_app/core/widgets/custom_appbar.dart';
import 'package:music_game_app/features/profile/presentation/widgets/custom_textfield.dart';
import 'package:music_game_app/features/profile/presentation/widgets/save_button.dart';

class UpdateNicknameScreen extends StatefulWidget {
  const UpdateNicknameScreen({super.key});

  @override
  State<UpdateNicknameScreen> createState() => _UpdateNicknameScreenState();
}

class _UpdateNicknameScreenState extends State<UpdateNicknameScreen> {
  final _nicknameController = TextEditingController(text: 'doe john');

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: CustomAppBar(
        title: 'Update My Nickname',
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      buildCustomTextField(
                        label: 'Nickname',
                        controller: _nicknameController,
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: const [
                          Icon(
                            Icons.check_circle_outline,
                            color: Colors.green,
                            size: 18,
                          ),
                          SizedBox(width: 8),
                          Text(
                            'This nickname is available',
                            style: TextStyle(
                              color: Colors.white54,
                              fontSize: 14,
                            ),
                          ),
                        ],
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