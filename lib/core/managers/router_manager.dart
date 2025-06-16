import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pennywise/core/constants/routes.dart';
import 'package:pennywise/core/helpers/extension_methods/string_extensions.dart';
import 'package:pennywise/core/managers/auth_manager.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pennywise/features/auth/presentation/pages/login_page.dart';
import 'package:pennywise/features/auth/presentation/pages/signup_page.dart';
import 'package:pennywise/features/home/presentation/pages/home_page.dart';

abstract interface class RouterManager {
  GoRouter get router;
  void initRouter();
  void go(String location, {Object? extra});
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
      routes: <RouteBase>[
        GoRoute(path: Routes.home, builder: (BuildContext context, GoRouterState state) => const HomePage()),
        GoRoute(
          path: Routes.login,
          builder: (BuildContext context, GoRouterState state) {
            final bool showSessionExpiredWarning = state.extra == null ? false : state.extra as bool;
            return BlocProvider<AuthBloc>(
              create: (_) => AuthBloc(),
              child: LoginPage(showSessionExpiredWarning: showSessionExpiredWarning),
            );
          },
        ),
        GoRoute(
          path: Routes.signUp,
          builder: (BuildContext context, GoRouterState state) =>
              BlocProvider<AuthBloc>(create: (_) => AuthBloc(), child: const SignUpPage()),
        ),
      ],
    );
  }

  @override
  void go(String location, {Object? extra}) {
    _router.go(location, extra: extra);
  }
}
