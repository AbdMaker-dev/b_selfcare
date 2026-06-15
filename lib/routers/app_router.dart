import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/routers/auth_guard.dart';
import 'package:b_selfcare/src/views/widgets/app_text.dart';
import 'package:b_selfcare/routers/app_router.gr.dart';
import 'package:flutter/material.dart';

// SPLASH
const String routeSplash = '/';

// 1. LOGIN
const String routeLogin = '/login';
const String routeLoginOtp = '$routeLogin/otp';
const String routeResetPwd = '/forgot-password';
const String routeChangePwd = '/reset-password';
const String routeInvitation = '/invitation';

// 2. APP MAIN
const String routeApp = '/app';
const String routeAppDashbord = 'dashbord';
const String routeAppMyFlotte = 'flotte';
const String routeAppMyCampagnes = 'campagnes';
const String routeAppProducts = 'products';
const String routeAppGroups = 'groupes';
const String routeAppNumbers = 'tels';
const String routeAppUsers   = 'users';
const String routeAppRecoveryResource   = 'resources';

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
    AutoRoute(path: routeResetPwd, page: ResetPasswordRoute.page),
    AutoRoute(path: routeChangePwd, page: ChangePasswordRoute.page),
    AutoRoute(path: '/invitation/:token', page: InvitationRoute.page),

    // APP MAIN
    AutoRoute(
      path: routeApp,
      page: LayoutRoute.page,
      guards: [AuthGuard()],
      children: [
        AutoRoute(path: routeAppDashbord, page: DashboardRoute.page),
        AutoRoute(path: routeAppMyFlotte, page: MyFlotteRoute.page),
        AutoRoute(path: routeAppGroups, page: MyGroupeRoute.page),
        AutoRoute(path: routeAppMyCampagnes, page: CampagneRoute.page),
        AutoRoute(path: routeAppNumbers, page: NumerosRoute.page),
        AutoRoute(path: routeAppProducts, page: ProductsRoute.page),
        AutoRoute(path: routeAppUsers,    page: UsersRoute.page),
        AutoRoute(path: routeAppRecoveryResource,    page: RecoveryResourceRoute.page),
      ],
    ),
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
