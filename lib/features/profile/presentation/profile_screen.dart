import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/profile/presentation/controllers/profile_screen_controller.dart';
import 'package:music_game_app/routes/app_routes.dart';


class ProfileScreen extends GetView<ProfileScreenController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color(0xFF1A235E),
      body: Stack(
        children: [

          Container(
            height: MediaQuery.of(context).size.height * 0.20,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [

                  Color(0xFF00E5FF),
                  Color(0xFF2979FF)
                ],
              ),
            ),
          ),



          //settings button
          Positioned(
            top: 50,
            right: 20,
            child: GestureDetector(
              onTap: (){Get.toNamed(AppRoutes.settingsScreen);},
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                  border: Border.all(

                    color: const Color(0xFF00E5FF),
                    width: 1.0,

                  ),
                ),
                child: const Icon(Icons.settings, color: Colors.white, size: 24),
              ),
            ),
          ),


          const Positioned(
            top: 55,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                "My Profile",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),


          Column(
            children: [
              const SizedBox(height: 120),


              Center(
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: const Color(0xFF00E5FF), width: 4),
                    color: const Color(0xFF80DEEA),
                  ),
                  child: const Icon(Icons.person, size: 100, color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),

              Obx(() => Text(
                controller.userName.value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              )),


              Obx(() => Text(
                controller.userName.value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              )),

              Obx(() => Text(
                controller.userEmail.value,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.7),
                  fontSize: 18,
                ),
              )),

              const SizedBox(height: 10),

              Obx(() => Text(
                controller.joinDate.value,
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.5),
                  fontSize: 14,
                ),
              )),

              const SizedBox(height: 30),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF00E5FF),
                        Color(0xFF2979FF)
                      ],
                    ),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildStatItem("team joined", controller.teamJoined.value, Icons.groups, Colors.cyanAccent),
                        VerticalDivider(color: Colors.white.withValues(alpha: 0.3), thickness: 1),
                        _buildStatItem("total wins", controller.totalWins.value, Icons.emoji_events, Colors.amber),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _buildStatItem(String label, int value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.15),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          "$value",
          style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 14),
        ),
      ],
    );
  }
}