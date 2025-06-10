import 'package:flutter/material.dart';

class AddTransactionButton extends StatelessWidget {
  final void Function() onPressed;

  const AddTransactionButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        side: BorderSide(color: Theme.of(context).colorScheme.primary, width: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add),
            Text(
              'Adicionar Transação',
              style: Theme.of(
                context,
              ).textTheme.bodyMedium!.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
