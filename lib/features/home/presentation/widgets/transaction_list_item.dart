import 'package:flutter/material.dart';
import 'package:pennywise/features/home/domain/entities/transaction.dart';

class TransactionListItem extends StatelessWidget {
  final Transaction transaction;

  const TransactionListItem({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: const Icon(Icons.local_grocery_store),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[Text(transaction.categoryName), Text(transaction.value.toString())],
      ),
      subtitle: Text(transaction.date.toString()),
    );
  }
}
