import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/services/local_helper.dart';

import 'app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final token = await getIt<LocaHelper>().getToken();

    if (token != null && token.isNotEmpty) {
      resolver.next();
    } else {
      router.replaceAll([const LoginRoute()]);
    }
  }
}
