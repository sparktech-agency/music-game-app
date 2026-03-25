import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AppBarWithLogo extends StatelessWidget implements PreferredSizeWidget {
  final String userName;

  const AppBarWithLogo({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      scrolledUnderElevation: 0,
      backgroundColor: const Color(0xFF0A0E21).withValues(alpha: 0.5),
      elevation: 0,
      titleSpacing: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 15, top: 8, bottom: 8),
        child: Container(

          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF42E8FF),
                Color(0xFF3B82F6),
              ],
            ),
          ),
          child: Center(
            child: SvgPicture.asset(
              'assets/images/logo_only.svg',
              colorFilter: const ColorFilter.mode(
                Colors.white,
                BlendMode.srcIn,
              ),
              width: 18,
              height: 18,
            ),
          ),
        ),
      ),
      title: Padding(
        padding: const EdgeInsets.only(left: 10),
        child: Text(
          userName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}