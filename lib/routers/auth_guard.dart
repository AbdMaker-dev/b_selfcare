import 'package:auto_route/auto_route.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/services/local_helper.dart';
import 'package:b_selfcare/src/views/pages/layout/cubit/layout_cubit.dart';
import 'package:b_selfcare/src/views/pages/login/cubit/login_cubit.dart';

import 'app_router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final isValid = await getIt<LocaHelper>().isTokenValid();

    if (isValid) {
      final layoutCubit = getIt<LayoutCubit>();
      if (layoutCubit.currentUser == null) {
        final success = await layoutCubit.fetchCurrentUser();
        if (!success) {
          router.replaceAll([const LoginRoute()]);
          return;
        }
        await getIt<LoginCubit>().scheduleTokenRefresh();
      }
      resolver.next();
    } else {
      router.replaceAll([const LoginRoute()]);
    }
  }
}
