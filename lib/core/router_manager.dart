import 'package:go_router/go_router.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/core/services/auth_session_manager.dart';
import 'package:pennywise/core/utils/extension_methods/string_extensions.dart';
import 'package:pennywise/features/auth/presentation/pages/login_page.dart';
import 'package:pennywise/features/auth/presentation/pages/signup_page.dart';
import 'package:pennywise/features/home/presentation/pages/home_page.dart';

final class RouterManager {
  GoRouter createRouter() {
    String? initialLocation;
    if (sl<AuthSessionManager>().accessToken.isNullOrEmpty()) {
      initialLocation = '/login';
    }
    return GoRouter(
      initialLocation: initialLocation,
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
        GoRoute(path: '/signup', builder: (context, state) => const SignUpPage()),
      ],
    );
  }
}
