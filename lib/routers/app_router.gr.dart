// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i5;
import 'package:b_selfcare/routers/app_router.dart' as _i4;
import 'package:b_selfcare/src/views/pages/login/login_otp_screen.dart' as _i1;
import 'package:b_selfcare/src/views/pages/login/login_screen.dart' as _i2;
import 'package:b_selfcare/src/views/pages/splash/splash_screen.dart' as _i3;

/// generated route for
/// [_i1.LoginOtpScreen]
class LoginOtpRoute extends _i5.PageRouteInfo<void> {
  const LoginOtpRoute({List<_i5.PageRouteInfo>? children})
    : super(LoginOtpRoute.name, initialChildren: children);

  static const String name = 'LoginOtpRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i1.LoginOtpScreen();
    },
  );
}

/// generated route for
/// [_i2.LoginScreen]
class LoginRoute extends _i5.PageRouteInfo<void> {
  const LoginRoute({List<_i5.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i2.LoginScreen();
    },
  );
}

/// generated route for
/// [_i3.SplashScreen]
class SplashRoute extends _i5.PageRouteInfo<void> {
  const SplashRoute({List<_i5.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i3.SplashScreen();
    },
  );
}

/// generated route for
/// [_i4.UnderDevelopmentScreen]
class UnderDevelopmentRoute extends _i5.PageRouteInfo<void> {
  const UnderDevelopmentRoute({List<_i5.PageRouteInfo>? children})
    : super(UnderDevelopmentRoute.name, initialChildren: children);

  static const String name = 'UnderDevelopmentRoute';

  static _i5.PageInfo page = _i5.PageInfo(
    name,
    builder: (data) {
      return const _i4.UnderDevelopmentScreen();
    },
  );
}
