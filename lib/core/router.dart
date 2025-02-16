import 'package:go_router/go_router.dart';
import 'package:pennywise/features/auth/presentation/pages/login_page.dart';
import 'package:pennywise/features/auth/presentation/pages/signup_page.dart';
import 'package:pennywise/features/home/presentation/pages/home_page.dart';

final router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const HomePage()),
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/signup', builder: (context, state) => const SignUpPage()),
  ],
);
