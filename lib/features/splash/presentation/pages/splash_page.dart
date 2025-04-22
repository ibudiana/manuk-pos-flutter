import 'package:flutter/material.dart';
import 'package:manuk_pos/core/theme/theme.dart';
import 'package:manuk_pos/features/splash/presentation/widgets/splash_logo.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Simulasi delay sebelum pindah ke halaman utama
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.go('/onboard'); // Ganti dengan rute yang sesuai
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundPrimaryColor,
      body: Center(
        child: SplashLogo(), // Pakai widget logo dari file terpisah
      ),
    );
  }
}
