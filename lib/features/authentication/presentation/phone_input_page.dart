import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_game_app/features/authentication/presentation/controllers/phone_controller.dart';

class PhoneInputPage extends StatelessWidget {
  const PhoneInputPage({super.key});

  @override
  Widget build(BuildContext context) {
    final PhoneController controller = Get.put(PhoneController());

    return Scaffold(
      backgroundColor: const Color(0xFF050A18),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white, size: 20),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Log In/Register',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w500),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 40),
                      const Text(
                        'Enter Your Phone Number',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 40),


                      Row(
                        children: [
                          _buildCountryCodePicker(controller),
                          const SizedBox(width: 15),
                          Expanded(child: _buildPhoneField(controller)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              _buildBottomActionArea(controller),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildCountryCodePicker(PhoneController controller) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: const Color(0xFF101625),
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: const Color(0xFF1E2746)),
      ),
      child: Obx(() => DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: controller.selectedCountryCode.value,
          dropdownColor: const Color(0xFF101625),
          icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
          style: const TextStyle(color: Colors.white, fontSize: 16),
          items: <String>['+1', '+880', '+91', '+44'].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (newValue) {
            controller.selectedCountryCode.value = newValue!;
          },
        ),
      )),
    );
  }


  Widget _buildPhoneField(PhoneController controller) {
    return TextField(
      controller: controller.phoneController,
      keyboardType: TextInputType.phone,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: 'Enter phone no.',
        hintStyle: const TextStyle(color: Colors.grey, fontSize: 16),
        prefixIcon: const Icon(Icons.phone_outlined, color: Colors.grey, size: 20),
        filled: true,
        fillColor: const Color(0xFF101625),
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
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


  Widget _buildBottomActionArea(PhoneController controller) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [

        GestureDetector(
          onTap: () => controller.verifyPhone(),
          child: Container(
            width: double.infinity,
            height: 60,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF42E8FF), Color(0xFF3B82F6)],
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Center(
              child: Text(
                "Next",
                style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          'We need to verify if the phone has been registered with Lyricraze',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.grey, fontSize: 13),
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}