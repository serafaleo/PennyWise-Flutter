import 'package:flutter/material.dart';

class BalanceCard extends StatelessWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.primary, borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Text('SALDO MENSAL', style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
            const SizedBox(height: 5),
            Text('R\$ 1.200,00', style: Theme.of(context).textTheme.displaySmall!.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
            const SizedBox(height: 10),
            DefaultTextStyle(
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Theme.of(context).colorScheme.onPrimary),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[Text('Receitas'), Text('Despesas')]),
                  Column(crossAxisAlignment: CrossAxisAlignment.end, children: <Widget>[Text('R\$ 3.000,00'), Text('R\$ 1.800,00')]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
