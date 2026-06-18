import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppBarWithLogo extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final VoidCallback? onTap;

  const AppBarWithLogo({super.key, required this.userName, this.onTap});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: false,
      titleSpacing: 16,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: const Color(0xFF0A0E21).withValues(alpha: 0.5),

      title: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(30),

        child: Row(
          mainAxisSize: MainAxisSize.min,

          children: [
            Container(
              width: 36,
              height: 36,

              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF42E8FF), Color(0xFF3B82F6)],
                ),
              ),

              child: Center(
                child: SvgPicture.asset(
                  'assets/images/logo_only.svg',
                  width: 18,
                  height: 18,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),

            const SizedBox(width: 12),

            Flexible(
              child: Text(
                userName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,

                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
