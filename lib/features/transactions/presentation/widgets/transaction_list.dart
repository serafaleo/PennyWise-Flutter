import 'package:flutter/material.dart';
import 'package:pennywise/features/transactions/domain/entities/transaction.dart';
import 'package:pennywise/features/transactions/presentation/widgets/transaction_list_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: transactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(Icons.price_check, size: 75, color: Theme.of(context).colorScheme.primary),
                Text(
                  'Nenhuma transação até o momento!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(color: Theme.of(context).colorScheme.primary),
                ),
              ],
            )
          : Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (BuildContext context, int index) {
                  final Transaction transaction = transactions[index];
                  return TransactionListItem(transaction: transaction);
                },
              ),
            ),
    );
  }
}
