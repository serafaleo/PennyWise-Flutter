import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pennywise/core/configs/theme.dart';
import 'package:pennywise/core/managers/auth_manager.dart';
import 'package:pennywise/core/managers/router_manager.dart';
import 'package:pennywise/core/service_locator.dart';
import 'package:pennywise/l10n/app_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  await sl<AuthManager>().tryRestoreSession();
  sl<RouterManager>().initRouter();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const Locale ptBR = Locale('pt', 'BR');
    return MaterialApp.router(
      title: 'PennyWise',
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      routerConfig: sl<RouterManager>().router,
      locale: ptBR,
      supportedLocales: const <Locale>[ptBR],
      localizationsDelegates: const <LocalizationsDelegate<Object>>[
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
