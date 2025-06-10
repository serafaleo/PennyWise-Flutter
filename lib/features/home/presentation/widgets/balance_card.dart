import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    const expensesColor = Color.fromARGB(255, 255, 158, 158);
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('SALDO MENSAL', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
            const SizedBox(height: 5),
            Text('R\$ 1.200,00', style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Receitas',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    Text('Despesas', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: expensesColor)),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'R\$ 3.000,00',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
                    ),
                    Text('R\$ 1.800,00', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: expensesColor)),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
