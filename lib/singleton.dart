import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import './singleton.config.dart';

GetIt getIt = GetIt.instance;

// @module
// abstract class RegisterModule {
//   @singleton
//   GlobalKey<NavigatorState> get navigatorKey => GlobalKey<NavigatorState>();
// }

@injectableInit
Future<GetIt> configure() async => getIt.init();
