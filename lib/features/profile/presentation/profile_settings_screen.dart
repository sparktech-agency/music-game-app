import 'package:flutter/material.dart';
import 'package:music_game_app/core/widgets/custom_appbar.dart';

class ProfileSettingsScreen extends StatelessWidget {
  const ProfileSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: CustomAppBar(
        title: 'Profile Settings',
      ),
      body: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Column(
          children: [

            _buildSettingsItem(
              icon: Icons.person_outline,
              title: "My Name",
              onTap: () {

              },
            ),
            const Divider(color: Colors.white12, thickness: 1, height: 1),


            _buildSettingsItem(
              icon: Icons.person_outline,
              title: "My Nickname",
              onTap: () {

              },
            ),
            const Divider(color: Colors.white12, thickness: 1, height: 1),


            _buildSettingsItem(
              icon: Icons.image_outlined,
              title: "Profile Picture",
              onTap: () {

              },
            ),
            const Divider(color: Colors.white12, thickness: 1, height: 1),
          ],
        ),
      ),
    );
  }


  Widget _buildSettingsItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return Theme(
      data: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
      ),
      child: ListTile(
        onTap: onTap,
        leading: Icon(icon, color: Colors.blueAccent, size: 26),
        title: Text(
          title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.w400,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          color: Colors.white,
          size: 16,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      ),
    );
  }
}