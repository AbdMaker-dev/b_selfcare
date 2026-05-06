import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/routers/app_router.dart';
import 'package:b_selfcare/routers/app_router.gr.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/services/local_helper.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/layout/cubit/layout_cubit.dart';
import 'package:b_selfcare/src/views/pages/login/cubit/login_cubit.dart';
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
    _bootstrap();
  }

  Future<void> _bootstrap() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    // Capture avant tout await pour éviter l'utilisation de context après un gap async
    final router = context.router;
    final isValid = await getIt<LocaHelper>().isTokenValid();
    if (isValid) {
      final success = await getIt<LayoutCubit>().fetchCurrentUser();
      if (success) {
        await getIt<LoginCubit>().scheduleTokenRefresh();
        router.pushPath('$routeApp/$routeAppDashbord');
      } else {
        router.replaceAll([const LoginRoute()]);
      }
    } else {
      router.replaceAll([const LoginRoute()]);
    }
  }

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

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
              s.appName,
              type: AppTextType.heading,
              color: Colors.white,
              fontSize: 42.rsp,
            ),
            SizedBox(height: 8.0.rh),
            AppText(
              s.appTagline,
              color: Colors.white.withValues(alpha: 0.8),
              fontSize: 16.rsp,
            ),
          ],
        ),
      ),
    );
  }
}
