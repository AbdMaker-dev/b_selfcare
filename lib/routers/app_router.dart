import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/routers/app_router.gr.dart';
import 'package:flutter/material.dart';

// SPLASH
const String routeSplash = '/';

// 1. LOGIN
const String routeLogin = '/login';
const String routeLoginOtp = '$routeLogin/otp';

@AutoRouterConfig(replaceInRouteName: 'Screen|Page,Route')
class AppRouter extends RootStackRouter {
  AppRouter({super.navigatorKey});

  @override
  RouteType get defaultRouteType => RouteType.custom(
    transitionsBuilder: TransitionsBuilders.noTransition,
    duration: Duration.zero,
    reverseDuration: Duration.zero,
  );

  @override
  List<AutoRoute> get routes => [
    // Splash screen
    AutoRoute(path: routeSplash, page: SplashRoute.page, initial: true),

    // LOGIN
    AutoRoute(path: routeLogin, page: LoginRoute.page),
    AutoRoute(path: routeLoginOtp, page: LoginOtpRoute.page),
  ];
}

@RoutePage()
class UnderDevelopmentScreen extends StatelessWidget {
  const UnderDevelopmentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: AppText.textHighlight('Fonctionnalité en développement'),
      ),
    );
  }
}
