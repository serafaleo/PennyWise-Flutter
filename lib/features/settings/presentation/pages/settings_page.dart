import 'package:flutter/material.dart';
import 'package:pennywise/core/widgets/drawer.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configurações'), centerTitle: true),
      drawer: const PennyWiseDrawer(),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
