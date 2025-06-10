import 'package:flutter/material.dart';
import 'package:pennywise/features/home/presentation/widgets/add_transaction_button.dart';
import 'package:pennywise/features/home/presentation/widgets/balance_card.dart';
import 'package:pennywise/features/home/presentation/widgets/month_selector.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    const double marginSize = 32.0;
    return Scaffold(
      appBar: AppBar(title: const Text('Transações'), centerTitle: true),
      drawer: const Drawer(),
      body: Padding(
        padding: const EdgeInsets.only(left: marginSize, right: marginSize),
        child: Column(
          children: [
            MonthSelector(onMonthChanged: (newDate) {}),
            const BalanceCard(),
            const SizedBox(height: 10),
            AddTransactionButton(onPressed: () {}),
          ],
        ),
      ),
    );
  }
}
