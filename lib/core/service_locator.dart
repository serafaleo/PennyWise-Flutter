import 'package:get_it/get_it.dart';
import 'package:pennywise/core/managers/auth_manager.dart';
import 'package:pennywise/core/managers/router_manager.dart';

final GetIt sl = GetIt.instance;

void setupServiceLocator() {
  sl.registerLazySingleton<AuthManager>(() => AuthManagerImpl());
  sl.registerLazySingleton<RouterManager>(() => RouterManagerImpl());
}
