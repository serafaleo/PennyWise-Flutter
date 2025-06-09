import 'package:flutter/material.dart';
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
    return MaterialApp.router(title: 'PennyWise', routerConfig: sl<RouterManager>().router);
  }
}
