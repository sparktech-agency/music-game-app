import 'package:flutter/material.dart';

class AuthButton extends StatelessWidget {

  final Widget icon;
  final String label;
  final VoidCallback onTap;
  final bool isLoading;

  const AuthButton({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 56,

      decoration:  BoxDecoration()


    );
  }
}
