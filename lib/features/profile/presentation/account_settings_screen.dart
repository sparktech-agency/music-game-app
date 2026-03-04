import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/core/widgets/custom_appbar.dart';

class AccountSettingsScreen extends StatelessWidget {
  const AccountSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0A0E21),
      appBar: CustomAppBar(
        title: 'Account Settings',
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [

            _buildSettingsItem(
              icon: Icons.lock_outline,
              title: "Change Password",
              onTap: () {},
            ),
            const Divider(color: Colors.white12, thickness: 1, height: 1),

            _buildSettingsItem(
              icon: Icons.music_note_outlined,
              title: "Connected Music API",
              onTap: () {},
            ),
            const Divider(color: Colors.white12, thickness: 1, height: 1),


            const Spacer(),


            const Divider(color: Colors.white12, thickness: 1, height: 1),
            _buildSettingsItem(
              icon: Icons.power_settings_new,
              title: "Log Out",
              onTap: () {
                _showLogoutDialog();
              },
            ),
            const Divider(color: Colors.white12, thickness: 1, height: 1),

            _buildSettingsItem(
              icon: Icons.delete_outline,
              title: "Delete My Account",
              onTap: () {},
            ),
            const Divider(color: Colors.white12, thickness: 1, height: 1),
            const SizedBox(height: 20),
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


  void _showLogoutDialog() {
    Get.defaultDialog(
      title: "Log Out",
      middleText: "Are you sure you want to log out?",
      textConfirm: "Yes",
      textCancel: "No",
      confirmTextColor: Colors.white,
      buttonColor: Colors.blueAccent,
      onConfirm: () {

        Get.back();
      },
    );
  }
}