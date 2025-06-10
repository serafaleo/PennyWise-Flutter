import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pennywise/core/helpers/extension_methods/string_extensions.dart';

class MonthIndicator extends StatelessWidget {
  final PageController pageController;
  final DateTime date;

  const MonthIndicator({super.key, required this.pageController, required this.date});

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 200);
    const curve = Curves.easeInOut;
    return Row(
      children: [
        IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () {
            pageController.nextPage(duration: duration, curve: curve);
          },
        ),
        Expanded(
          child: Center(
            child: Text(
              DateFormat('MMMM yyyy', Localizations.localeOf(context).toString()).format(date).toTitleCase(),
              style: Theme.of(context).textTheme.titleMedium!.copyWith(fontWeight: FontWeight.bold),
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.chevron_right),
          onPressed: () {
            pageController.previousPage(duration: duration, curve: curve);
          },
        ),
      ],
    );
  }
}
