import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/prerequisite/presentation/controllers/prerequisite_controller.dart';
import 'package:music_game_app/routes/app_routes.dart';


class RoundSelection extends StatelessWidget {
  RoundSelection({super.key});

  final PrerequisiteController controller = Get.put(PrerequisiteController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Color(0xFF5C62FF), Color(0xFF2E33FF), Color(0xFF191ED2)],
              ),
            ),
          ),


          SafeArea(
            child: Column(
              children: [

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(onPressed: () => Get.back(), icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white)),
                      const Expanded(
                        child: Text(
                          'How many rounds\nto play?',
                          textAlign: TextAlign.center,
                          style: TextStyle(color: Colors.white, fontSize: 26, fontWeight: FontWeight.bold, height: 1.2),
                        ),
                      ),
                      IconButton(onPressed: () {}, icon: const Icon(Icons.close, color: Colors.white, size: 30)),
                    ],
                  ),
                ),

                const Spacer(),


                const SizedBox(height: 250),

                const Text(
                  'Please select',
                  style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 25),


                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [2, 3, 4, 5].map((round) => _buildRoundCircle(round)).toList(),
                ),

                const Spacer(),


                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: GestureDetector(
                    onTap: () {

                      controller.proceedToNextPage("numberOfRounds");
                    },
                    child: Container(
                      height: 65,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                        gradient: const LinearGradient(
                          colors: [Color(0xFF39E3FE), Color(0xFF2C6BFF)],
                        ),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 10, offset: const Offset(0, 5))
                        ],
                      ),
                      child: const Center(
                        child: Text(
                          'Next',
                          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _buildRoundCircle(int round) {
    return Obx(() {
      bool isSelected = controller.numberOfRound.value == round;
      return GestureDetector(
        onTap: () => controller.selectNumberOfRound(round),
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 70,
              width: 70,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? const Color(0xFF42E8E0) : Colors.transparent,
                border: Border.all(color: isSelected ? Colors.transparent : Colors.white, width: 4),
              ),
              child: Center(
                child: Text(
                  '$round',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
            ),

            if (isSelected)
              Container(
                padding: const EdgeInsets.all(2),
                decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                child: const Icon(Icons.check, size: 15, color: Color(0xFF42E8E0)),
              ),
          ],
        ),
      );
    });
  }
}