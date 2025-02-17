import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pennywise/core/configs/theme.dart';
import 'package:pennywise/core/router_manager.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/core/services/auth_session_manager.dart';
import 'package:pennywise/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:pennywise/features/home/presentation/bloc/home_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await sl<AuthSessionManager>().tryRestoreSession();
  GoRouter router = RouterManager().initRouter();

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => AuthBloc()), BlocProvider(create: (_) => HomeBloc())],
      child: MainApp(router: router),
    ),
  );
}

class MainApp extends StatelessWidget {
  final GoRouter router;

  const MainApp({super.key, required this.router});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PennyWise',
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      routerConfig: router,
    );
  }
}
