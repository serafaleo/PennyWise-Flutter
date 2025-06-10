import 'package:flutter/material.dart';
import 'package:pennywise/core/helpers/extension_methods/datetime_extensions.dart';
import 'package:pennywise/features/home/domain/entities/transaction.dart';
import 'package:pennywise/features/home/presentation/widgets/add_transaction_button.dart';
import 'package:pennywise/features/home/presentation/widgets/balance_card.dart';
import 'package:pennywise/features/home/presentation/widgets/month_indicator.dart';
import 'package:pennywise/features/home/presentation/widgets/transaction_list.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late final PageController _pageController;
  late DateTime _currentDate;
  late int _lastPageIndex;

  // final _transactions = [Transaction(categoryName: 'Mercado', value: -50, date: DateTime.now())];
  final List<Transaction> _transactions = [];

  @override
  void initState() {
    _pageController = PageController();
    _currentDate = DateTime.now();
    _lastPageIndex = 0;
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const double marginSize = 32.0;
    return Scaffold(
      appBar: AppBar(title: const Text('Transações'), centerTitle: true),
      drawer: const Drawer(),
      body: PageView.builder(
        reverse: true,
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) {
          //print(index);
          return Padding(
            padding: const EdgeInsets.only(left: marginSize, right: marginSize),
            child: Column(
              children: [
                MonthIndicator(pageController: _pageController, date: _currentDate),
                const BalanceCard(),
                const SizedBox(height: 10),
                AddTransactionButton(onPressed: () {}),
                TransactionList(transactions: _transactions),
              ],
            ),
          );
        },
      ),
    );
  }

  _onPageChanged(int newPageIndex) {
    setState(() {
      // the higher the index, the older the date
      if (newPageIndex > _lastPageIndex) {
        _currentDate = _currentDate.addMonths(-1);
      } else if (newPageIndex < _lastPageIndex) {
        _currentDate = _currentDate.addMonths(1);
      }
      _lastPageIndex = newPageIndex;
    });
  }
}
