import 'package:flutter/material.dart';
import 'package:pennywise/core/helpers/extension_methods/datetime_extensions.dart';
import 'package:pennywise/core/widgets/drawer.dart';
import 'package:pennywise/features/transactions/domain/entities/transaction.dart';
import 'package:pennywise/features/transactions/presentation/widgets/add_transaction_button.dart';
import 'package:pennywise/features/transactions/presentation/widgets/balance_card.dart';
import 'package:pennywise/features/transactions/presentation/widgets/month_indicator.dart';
import 'package:pennywise/features/transactions/presentation/widgets/transaction_list.dart';

class TransactionsPage extends StatefulWidget {
  const TransactionsPage({super.key});

  @override
  State<TransactionsPage> createState() => _TransactionsPageState();
}

class _TransactionsPageState extends State<TransactionsPage> with TickerProviderStateMixin {
  late final PageController _pageController;
  late DateTime _currentDate;
  late int _lastPageIndex;

  // final _transactions = [Transaction(categoryName: 'Mercado', value: -50, date: DateTime.now())];
  final List<Transaction> _transactions = <Transaction>[];

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
      drawer: const PennyWiseDrawer(),
      body: PageView.builder(
        reverse: true,
        controller: _pageController,
        onPageChanged: _onPageChanged,
        itemBuilder: (BuildContext context, int index) {
          //print(index);
          return Padding(
            padding: const EdgeInsets.only(left: marginSize, right: marginSize),
            child: Column(
              children: <Widget>[
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

  void _onPageChanged(int newPageIndex) {
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
