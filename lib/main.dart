import 'dart:io';
import 'package:b_selfcare/generated/l10n.dart';
import 'package:b_selfcare/routers/app_route_observer.dart';
import 'package:b_selfcare/routers/app_router.dart';
import 'package:b_selfcare/singleton.dart';
import 'package:b_selfcare/src/data/models/app_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:toastification/toastification.dart';
import 'package:b_selfcare/src/utils/app_theme.dart';
import 'package:url_strategy/url_strategy.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)..badCertificateCallback = (X509Certificate cert, String host, int port) => true;
  }
}

void main() {
  mainCommon();
}

void mainCommon() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await configure();
  setPathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
      child: ScreenUtilInit(
        designSize: const Size(1728, 1117),
        minTextAdapt: true,
        splitScreenMode: true,
        useInheritedMediaQuery: true,
        ensureScreenSize: true,
        child: ToastificationWrapper(
          child: MaterialApp.router(
            title: AppConfig.shared.appName,
            theme: AppTheme.lightTheme,
            routerConfig: _appRouter.config(
            navigatorObservers: () => [
              AppRouteObserver(
                onRouteChage: ({route, args}) {
                  // appMainCubit.onRouteChange(route: route, args: args);
                },
              ),
              ],
            ),
            debugShowCheckedModeBanner: false,
            localizationsDelegates: const [
              S.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            locale: const Locale('fr', 'FR'),
            builder: (context, child) {
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                FocusScopeNode currentFocus = FocusScope.of(context);
                if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
                  currentFocus.unfocus();
                }
              },
              child: EasyLoading.init()(context, child),
            );
          },
          ),
        ),
      ),
    );
  }
}
// dart run build_runner build --delete-conflicting-outputs
// flutter pub run intl_utils:generate
// flutter packages pub run build_runner build
// flutter run -d chrom -t lib/main_dev.dart
// flutter run -d chrom -t lib/main_prod.dart
