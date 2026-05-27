import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/gen/assets.gen.dart';
import 'package:b_selfcare/routers/app_router.dart';
import 'package:b_selfcare/routers/app_router.gr.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/services/local_helper.dart';
import 'package:b_selfcare/src/utils/app_colors.dart';
import 'package:b_selfcare/src/utils/responsive_extention.dart';
import 'package:b_selfcare/src/views/pages/layout/cubit/layout_cubit.dart';
import 'package:b_selfcare/src/views/pages/login/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

@RoutePage()
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _logoCtrl;
  late final AnimationController _loaderCtrl;

  late final Animation<double> _logoFade;
  late final Animation<double> _logoScale;

  @override
  void initState() {
    super.initState();

    _logoCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );

    _loaderCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1800),
    );

    _logoFade = CurvedAnimation(parent: _logoCtrl, curve: Curves.easeIn);
    _logoScale = Tween<double>(begin: 0.82, end: 1.0).animate(
      CurvedAnimation(parent: _logoCtrl, curve: Curves.easeOutBack),
    );
    _logoCtrl.forward();
    Future.delayed(const Duration(milliseconds: 400), () {
      if (mounted) _loaderCtrl.repeat();
    });

    _bootstrap();
  }

  @override
  void dispose() {
    _logoCtrl.dispose();
    _loaderCtrl.dispose();
    super.dispose();
  }

  Future<void> _bootstrap() async {
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
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
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: AppColors.primaryGradient),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Logo centré avec fade + scale
            FadeTransition(
              opacity: _logoFade,
              child: ScaleTransition(
                scale: _logoScale,
                child: SvgPicture.asset(
                  Assets.logo.logo,
                  width: 200.rw,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            // Barre de chargement pulsante en bas
            Positioned(
              bottom: 60.rh,
              left: 80.rw,
              right: 80.rw,
              child: Column(
                children: [
                  AnimatedBuilder(
                    animation: _loaderCtrl,
                    builder: (_, _) {
                      return ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: null,
                          minHeight: 3,
                          backgroundColor: Colors.white.withValues(alpha: 0.15),
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white.withValues(alpha: 0.85),
                          ),
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 14.rh),
                  _PulsingDots(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PulsingDots extends StatefulWidget {
  @override
  State<_PulsingDots> createState() => _PulsingDotsState();
}

class _PulsingDotsState extends State<_PulsingDots>
    with TickerProviderStateMixin {
  late final List<AnimationController> _controllers;
  late final List<Animation<double>> _anims;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      3,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 600),
      ),
    );
    _anims = _controllers
        .map((c) => Tween<double>(begin: 0.4, end: 1.0).animate(
              CurvedAnimation(parent: c, curve: Curves.easeInOut),
            ))
        .toList();

    for (int i = 0; i < 3; i++) {
      Future.delayed(Duration(milliseconds: i * 180), () {
        if (mounted) { _controllers[i].repeat(reverse: true); }
      });
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(3, (i) {
        return AnimatedBuilder(
          animation: _anims[i],
          builder: (_, _) => Container(
            margin: EdgeInsets.symmetric(horizontal: 4.rw),
            width: 6.rw,
            height: 6.rw,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: _anims[i].value),
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }
}
