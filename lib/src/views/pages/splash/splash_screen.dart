import 'package:b_selfcare/routers/app_router.gr.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToNext();
  }

  void _navigateToNext() async {
    await Future.delayed(const Duration(seconds: 2));
    if (mounted) {
      context.router.replaceAll([const LoginRoute()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: AppColors.primaryGradient,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.health_and_safety_outlined,
              size: 80.0.rh,
              color: Colors.white,
            ),
            SizedBox(height: 24.0.rh),
            AppText(
              'B-Selfcare',
              type: AppTextType.heading,
              color: Colors.white,
              fontSize: 42.rsp,
            ),
            SizedBox(height: 8.0.rh),
            AppText(
              'Votre santé, notre priorité',
              color: Colors.white.withOpacity(0.8),
              fontSize: 16.rsp,
            ),
          ],
        ),
      ),
    );
  }
}
