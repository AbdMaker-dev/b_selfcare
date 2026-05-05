// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:b_selfcare/routers/app_router.dart' as _i10;
import 'package:b_selfcare/src/views/pages/campagne/campagne_screen.dart'
    as _i1;
import 'package:b_selfcare/src/views/pages/dashboard/dashboard_screen.dart'
    as _i3;
import 'package:b_selfcare/src/views/pages/layout/layout_screen.dart' as _i4;
import 'package:b_selfcare/src/views/pages/login/login_otp_screen.dart' as _i5;
import 'package:b_selfcare/src/views/pages/login/login_screen.dart' as _i6;
import 'package:b_selfcare/src/views/pages/my_flotte/my_flotte_screen.dart'
    as _i7;
import 'package:b_selfcare/src/views/pages/reset_password/change_password_screen.dart'
    as _i2;
import 'package:b_selfcare/src/views/pages/dashboard/dashboard_screen.dart'
    as _i2;
import 'package:b_selfcare/src/views/pages/layout/layout_screen.dart' as _i3;
import 'package:b_selfcare/src/views/pages/login/login_otp_screen.dart' as _i4;
import 'package:b_selfcare/src/views/pages/login/login_screen.dart' as _i5;
import 'package:b_selfcare/src/views/pages/my_flotte/my_flotte_screen.dart'
    as _i6;
import 'package:b_selfcare/src/views/pages/products/products_screen.dart'
    as _i7;
import 'package:b_selfcare/src/views/pages/reset_password/change_password_screen.dart'
    as _i1;
import 'package:b_selfcare/src/views/pages/reset_password/reset_password_screen.dart'
    as _i8;
import 'package:b_selfcare/src/views/pages/splash/splash_screen.dart' as _i9;
import 'package:flutter/material.dart' as _i12;

/// generated route for
/// [_i1.CampagneScreen]
class CampagneRoute extends _i11.PageRouteInfo<void> {
  const CampagneRoute({List<_i11.PageRouteInfo>? children})
    : super(CampagneRoute.name, initialChildren: children);

  static const String name = 'CampagneRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i1.CampagneScreen();
    },
  );
}

/// generated route for
/// [_i2.ChangePasswordScreen]
/// [_i1.ChangePasswordScreen]
class ChangePasswordRoute extends _i11.PageRouteInfo<ChangePasswordRouteArgs> {
  ChangePasswordRoute({
    _i12.Key? key,
    String token = '',
    String email = '',
    List<_i11.PageRouteInfo>? children,
  }) : super(
         ChangePasswordRoute.name,
         args: ChangePasswordRouteArgs(key: key, token: token, email: email),
         rawQueryParams: {'token': token, 'email': email},
         initialChildren: children,
       );

  static const String name = 'ChangePasswordRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final queryParams = data.queryParams;
      final args = data.argsAs<ChangePasswordRouteArgs>(
        orElse: () => ChangePasswordRouteArgs(
          token: queryParams.getString('token', ''),
          email: queryParams.getString('email', ''),
        ),
      );
      return _i2.ChangePasswordScreen(
        key: args.key,
        token: args.token,
        email: args.email,
      );
    },
  );
}

class ChangePasswordRouteArgs {
  const ChangePasswordRouteArgs({this.key, this.token = '', this.email = ''});

  final _i12.Key? key;

  final String token;

  final String email;

  @override
  String toString() {
    return 'ChangePasswordRouteArgs{key: $key, token: $token, email: $email}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ChangePasswordRouteArgs) return false;
    return key == other.key && token == other.token && email == other.email;
  }

  @override
  int get hashCode => key.hashCode ^ token.hashCode ^ email.hashCode;
}

/// generated route for
/// [_i3.DashboardScreen]
/// [_i2.DashboardScreen]
class DashboardRoute extends _i11.PageRouteInfo<void> {
  const DashboardRoute({List<_i11.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i3.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i4.LayoutScreen]
/// [_i3.LayoutScreen]
class LayoutRoute extends _i11.PageRouteInfo<void> {
  const LayoutRoute({List<_i11.PageRouteInfo>? children})
    : super(LayoutRoute.name, initialChildren: children);

  static const String name = 'LayoutRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i4.LayoutScreen();
    },
  );
}

/// generated route for
/// [_i5.LoginOtpScreen]
/// [_i4.LoginOtpScreen]
class LoginOtpRoute extends _i11.PageRouteInfo<void> {
  const LoginOtpRoute({List<_i11.PageRouteInfo>? children})
    : super(LoginOtpRoute.name, initialChildren: children);

  static const String name = 'LoginOtpRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i5.LoginOtpScreen();
    },
  );
}

/// generated route for
/// [_i6.LoginScreen]
/// [_i5.LoginScreen]
class LoginRoute extends _i11.PageRouteInfo<void> {
  const LoginRoute({List<_i11.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i6.LoginScreen();
    },
  );
}

/// generated route for
/// [_i7.MyFlotteScreen]
/// [_i6.MyFlotteScreen]
class MyFlotteRoute extends _i11.PageRouteInfo<void> {
  const MyFlotteRoute({List<_i11.PageRouteInfo>? children})
    : super(MyFlotteRoute.name, initialChildren: children);

  static const String name = 'MyFlotteRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i7.MyFlotteScreen();
    },
  );
}

/// generated route for
/// [_i7.ProductsScreen]
class ProductsRoute extends _i11.PageRouteInfo<void> {
  const ProductsRoute({List<_i11.PageRouteInfo>? children})
    : super(ProductsRoute.name, initialChildren: children);

  static const String name = 'ProductsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i7.ProductsScreen();
    },
  );
}

/// generated route for
/// [_i8.ResetPasswordScreen]
class ResetPasswordRoute extends _i11.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i11.PageRouteInfo>? children})
    : super(ResetPasswordRoute.name, initialChildren: children);

  static const String name = 'ResetPasswordRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i8.ResetPasswordScreen();
    },
  );
}

/// generated route for
/// [_i9.SplashScreen]
class SplashRoute extends _i11.PageRouteInfo<void> {
  const SplashRoute({List<_i11.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.SplashScreen();
    },
  );
}

/// generated route for
/// [_i10.UnderDevelopmentScreen]
class UnderDevelopmentRoute extends _i11.PageRouteInfo<void> {
  const UnderDevelopmentRoute({List<_i11.PageRouteInfo>? children})
    : super(UnderDevelopmentRoute.name, initialChildren: children);

  static const String name = 'UnderDevelopmentRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.UnderDevelopmentScreen();
    },
  );
}
