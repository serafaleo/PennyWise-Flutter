import 'package:flutter/material.dart';
import 'package:pennywise/features/home/presentation/widgets/month_selector.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('PennyWise')),
      body: Column(children: [MonthSelector(onMonthChanged: (newDate) {})]),
    );
  }
}
