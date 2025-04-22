import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Bounce(
      duration: const Duration(seconds: 2),
      child: Image.asset(
        'assets/images/logo.png',
        width: 150,
        height: 150,
      ),
    );
  }
}
