// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:b_selfcare/routers/app_router.dart' as _i13;
import 'package:b_selfcare/src/views/pages/campagne/campagne_screen.dart'
    as _i1;
import 'package:b_selfcare/src/views/pages/dashboard/dashboard_screen.dart'
    as _i3;
import 'package:b_selfcare/src/views/pages/groupe/my_groupe_screen.dart' as _i8;
import 'package:b_selfcare/src/views/pages/layout/layout_screen.dart' as _i4;
import 'package:b_selfcare/src/views/pages/login/login_otp_screen.dart' as _i5;
import 'package:b_selfcare/src/views/pages/login/login_screen.dart' as _i6;
import 'package:b_selfcare/src/views/pages/my_flotte/my_flotte_screen.dart'
    as _i7;
import 'package:b_selfcare/src/views/pages/numeros/numeros_screen.dart' as _i9;
import 'package:b_selfcare/src/views/pages/products/products_screen.dart'
    as _i10;
import 'package:b_selfcare/src/views/pages/reset_password/change_password_screen.dart'
    as _i2;
import 'package:b_selfcare/src/views/pages/reset_password/reset_password_screen.dart'
    as _i11;
import 'package:b_selfcare/src/views/pages/splash/splash_screen.dart' as _i12;
import 'package:flutter/material.dart' as _i15;

/// generated route for
/// [_i1.CampagneScreen]
class CampagneRoute extends _i14.PageRouteInfo<void> {
  const CampagneRoute({List<_i14.PageRouteInfo>? children})
    : super(CampagneRoute.name, initialChildren: children);

  static const String name = 'CampagneRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i1.CampagneScreen();
    },
  );
}

/// generated route for
/// [_i2.ChangePasswordScreen]
class ChangePasswordRoute extends _i14.PageRouteInfo<ChangePasswordRouteArgs> {
  ChangePasswordRoute({
    _i15.Key? key,
    String token = '',
    String email = '',
    List<_i14.PageRouteInfo>? children,
  }) : super(
         ChangePasswordRoute.name,
         args: ChangePasswordRouteArgs(key: key, token: token, email: email),
         rawQueryParams: {'token': token, 'email': email},
         initialChildren: children,
       );

  static const String name = 'ChangePasswordRoute';

  static _i14.PageInfo page = _i14.PageInfo(
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

  final _i15.Key? key;

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
class DashboardRoute extends _i14.PageRouteInfo<void> {
  const DashboardRoute({List<_i14.PageRouteInfo>? children})
    : super(DashboardRoute.name, initialChildren: children);

  static const String name = 'DashboardRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i3.DashboardScreen();
    },
  );
}

/// generated route for
/// [_i4.LayoutScreen]
class LayoutRoute extends _i14.PageRouteInfo<void> {
  const LayoutRoute({List<_i14.PageRouteInfo>? children})
    : super(LayoutRoute.name, initialChildren: children);

  static const String name = 'LayoutRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i4.LayoutScreen();
    },
  );
}

/// generated route for
/// [_i5.LoginOtpScreen]
class LoginOtpRoute extends _i14.PageRouteInfo<void> {
  const LoginOtpRoute({List<_i14.PageRouteInfo>? children})
    : super(LoginOtpRoute.name, initialChildren: children);

  static const String name = 'LoginOtpRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i5.LoginOtpScreen();
    },
  );
}

/// generated route for
/// [_i6.LoginScreen]
class LoginRoute extends _i14.PageRouteInfo<void> {
  const LoginRoute({List<_i14.PageRouteInfo>? children})
    : super(LoginRoute.name, initialChildren: children);

  static const String name = 'LoginRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i6.LoginScreen();
    },
  );
}

/// generated route for
/// [_i7.MyFlotteScreen]
class MyFlotteRoute extends _i14.PageRouteInfo<void> {
  const MyFlotteRoute({List<_i14.PageRouteInfo>? children})
    : super(MyFlotteRoute.name, initialChildren: children);

  static const String name = 'MyFlotteRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i7.MyFlotteScreen();
    },
  );
}

/// generated route for
/// [_i8.MyGroupeScreen]
class MyGroupeRoute extends _i14.PageRouteInfo<void> {
  const MyGroupeRoute({List<_i14.PageRouteInfo>? children})
    : super(MyGroupeRoute.name, initialChildren: children);

  static const String name = 'MyGroupeRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i8.MyGroupeScreen();
    },
  );
}

/// generated route for
/// [_i9.NumerosScreen]
class NumerosRoute extends _i14.PageRouteInfo<void> {
  const NumerosRoute({List<_i14.PageRouteInfo>? children})
    : super(NumerosRoute.name, initialChildren: children);

  static const String name = 'NumerosRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i9.NumerosScreen();
    },
  );
}

/// generated route for
/// [_i10.ProductsScreen]
class ProductsRoute extends _i14.PageRouteInfo<void> {
  const ProductsRoute({List<_i14.PageRouteInfo>? children})
    : super(ProductsRoute.name, initialChildren: children);

  static const String name = 'ProductsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i10.ProductsScreen();
    },
  );
}

/// generated route for
/// [_i11.ResetPasswordScreen]
class ResetPasswordRoute extends _i14.PageRouteInfo<void> {
  const ResetPasswordRoute({List<_i14.PageRouteInfo>? children})
    : super(ResetPasswordRoute.name, initialChildren: children);

  static const String name = 'ResetPasswordRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i11.ResetPasswordScreen();
    },
  );
}

/// generated route for
/// [_i12.SplashScreen]
class SplashRoute extends _i14.PageRouteInfo<void> {
  const SplashRoute({List<_i14.PageRouteInfo>? children})
    : super(SplashRoute.name, initialChildren: children);

  static const String name = 'SplashRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i12.SplashScreen();
    },
  );
}

/// generated route for
/// [_i13.UnderDevelopmentScreen]
class UnderDevelopmentRoute extends _i14.PageRouteInfo<void> {
  const UnderDevelopmentRoute({List<_i14.PageRouteInfo>? children})
    : super(UnderDevelopmentRoute.name, initialChildren: children);

  static const String name = 'UnderDevelopmentRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i13.UnderDevelopmentScreen();
    },
  );
}
