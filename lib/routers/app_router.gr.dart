// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
<<<<<<< HEAD
import 'package:auto_route/auto_route.dart' as _i6;
import 'package:b_selfcare/routers/app_router.dart' as _i5;
import 'package:b_selfcare/src/views/pages/login/login_otp_screen.dart' as _i1;
import 'package:b_selfcare/src/views/pages/login/login_screen.dart' as _i2;
import 'package:b_selfcare/src/views/pages/reset_password/reset_password_screen.dart'
    as _i3;
import 'package:b_selfcare/src/views/pages/splash/splash_screen.dart' as _i4;

/// generated route for
/// [_i1.LoginOtpScreen]
class LoginOtpRoute extends _i6.PageRouteInfo<void> {
  const LoginOtpRoute({List<_i6.PageRouteInfo>? children})
=======
import 'package:auto_route/auto_route.dart' as _i7;
import 'package:b_selfcare/routers/app_router.dart' as _i6;
import 'package:b_selfcare/src/views/pages/dashboard/dashboard_screen.dart'
    as _i1;
import 'package:b_selfcare/src/views/pages/layout/layout_screen.dart' as _i2;
import 'package:b_selfcare/src/views/pages/login/login_otp_screen.dart' as _i3;
import 'package:b_selfcare/src/views/pages/login/login_screen.dart' as _i4;
import 'package:b_selfcare/src/views/pages/splash/splash_screen.dart' as _i5;

/// generated route for
/// [_i1.DashboardScreen]
class DashboardRoute extends _i7.PageRouteInfo<void> {
  const DashboardRoute({List<_i7.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i1.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i2.LayoutScreen]
class LayoutRoute extends _i7.PageRouteInfo<void> {
  const LayoutRoute({List<_i7.PageRouteInfo>? children})
    : super(LayoutRoute.name, initialChildren: children);

  static const String name = 'LayoutRoute';

  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i2.LayoutScreen();
    },
  );
}

/// generated route for
/// [_i3.LoginOtpScreen]
class LoginOtpRoute extends _i7.PageRouteInfo<void> {
  const LoginOtpRoute({List<_i7.PageRouteInfo>? children})
>>>>>>> main
    : super(LoginOtpRoute.name, initialChildren: children);

  static const String name = 'LoginOtpRoute';

<<<<<<< HEAD
  static _i6.PageInfo page = _i6.PageInfo(
=======
  static _i7.PageInfo page = _i7.PageInfo(
>>>>>>> main
    name,
    builder: (data) {
      return const _i3.LoginOtpScreen();
    },
  );
}

/// generated route for
<<<<<<< HEAD
/// [_i2.LoginScreen]
class LoginRoute extends _i6.PageRouteInfo<void> {
  const LoginRoute({List<_i6.PageRouteInfo>? children})
=======
/// [_i4.LoginScreen]
class LoginRoute extends _i7.PageRouteInfo<void> {
  const LoginRoute({List<_i7.PageRouteInfo>? children})
>>>>>>> main
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

<<<<<<< HEAD
  static _i6.PageInfo page = _i6.PageInfo(
=======
  static _i7.PageInfo page = _i7.PageInfo(
>>>>>>> main
    name,
    builder: (data) {
      return const _i4.LoginScreen();
    },
  );
}

/// generated route for
<<<<<<< HEAD
/// [_i3.ResetPasswordScreen]
class ResetPasswordRoute extends _i6.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i6.PageRouteInfo>? children})
    : super(ResetPasswordRoute.name, initialChildren: children);
=======
/// [_i5.SplashScreen]
class SplashRoute extends _i7.PageRouteInfo<void> {
  const SplashRoute({List<_i7.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);
>>>>>>> main

  static const String name = 'ResetPasswordRoute';

<<<<<<< HEAD
  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i3.ResetPasswordScreen();
=======
  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i5.SplashScreen();
>>>>>>> main
    },
  );
}

/// generated route for
<<<<<<< HEAD
/// [_i4.SplashScreen]
class SplashRoute extends _i6.PageRouteInfo<void> {
  const SplashRoute({List<_i6.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i4.SplashScreen();
    },
  );
}

/// generated route for
/// [_i5.UnderDevelopmentScreen]
class UnderDevelopmentRoute extends _i6.PageRouteInfo<void> {
  const UnderDevelopmentRoute({List<_i6.PageRouteInfo>? children})
=======
/// [_i6.UnderDevelopmentScreen]
class UnderDevelopmentRoute extends _i7.PageRouteInfo<void> {
  const UnderDevelopmentRoute({List<_i7.PageRouteInfo>? children})
>>>>>>> main
    : super(UnderDevelopmentRoute.name, initialChildren: children);

  static const String name = 'UnderDevelopmentRoute';

<<<<<<< HEAD
  static _i6.PageInfo page = _i6.PageInfo(
    name,
    builder: (data) {
      return const _i5.UnderDevelopmentScreen();
=======
  static _i7.PageInfo page = _i7.PageInfo(
    name,
    builder: (data) {
      return const _i6.UnderDevelopmentScreen();
>>>>>>> main
    },
  );
}
