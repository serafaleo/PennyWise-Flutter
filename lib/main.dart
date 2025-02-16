import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pennywise/core/configs/theme.dart';
import 'package:pennywise/core/router.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/features/auth/presentation/bloc/auth_bloc.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  runApp(
    MultiBlocProvider(providers: [BlocProvider(create: (_) => AuthBloc())], child: const MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

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
