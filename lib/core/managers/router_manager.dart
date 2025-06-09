import 'package:go_router/go_router.dart';
import 'package:pennywise/core/constants/routes.dart';
import 'package:pennywise/core/helpers/extension_methods/string_extensions.dart';
import 'package:pennywise/core/managers/auth_manager.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/features/home/presentation/pages/home_page.dart';

abstract interface class RouterManager {
  GoRouter get router;
  void initRouter();
}

final class RouterManagerImpl implements RouterManager {
  late final GoRouter _router;

  @override
  GoRouter get router => _router;

  @override
  void initRouter() {
    String initialLocation = Routes.home;
    if (sl<AuthManager>().accessToken.isNullOrEmpty()) {
      initialLocation = Routes.login;
    }
    _router = GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(path: Routes.home, builder: (context, state) => const HomePage()),
        //GoRoute(path: Routes.home, builder: (context, state) => const HomePage()),
      ],
    );
  }
}
