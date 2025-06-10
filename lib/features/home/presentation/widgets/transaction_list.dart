import 'package:flutter/material.dart';
import 'package:pennywise/features/home/domain/entities/transaction.dart';
import 'package:pennywise/features/home/presentation/widgets/transaction_list_item.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  const TransactionList({super.key, required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: transactions.isEmpty
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
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
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  return TransactionListItem(transaction: transaction);
                },
              ),
            ),
    );
  }
}
