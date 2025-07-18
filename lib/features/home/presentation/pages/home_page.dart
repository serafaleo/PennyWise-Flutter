import 'package:flutter/material.dart';
import 'package:pennywise/core/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: true),
      drawer: const PennyWiseDrawer(),
      body: const Center(
        child: Text('Home'),
      ),
    );
  }
}
