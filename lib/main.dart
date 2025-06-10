import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pennywise/core/configs/theme.dart';
import 'package:pennywise/core/managers/router_manager.dart';
import 'package:pennywise/core/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  setupServiceLocator();
  // TODO(serafaleo): tryRestoreSession
  sl<RouterManager>().initRouter();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    const ptBR = Locale('pt', 'BR');
    return MaterialApp.router(
      title: 'PennyWise',
      theme: buildTheme(Brightness.light),
      darkTheme: buildTheme(Brightness.dark),
      themeMode: ThemeMode.system,
      routerConfig: sl<RouterManager>().router,
      locale: ptBR,
      supportedLocales: const [ptBR],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
