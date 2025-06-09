import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pennywise/core/helpers/extension_methods/datetime_extensions.dart';
import 'package:pennywise/core/helpers/extension_methods/string_extensions.dart';

class MonthSelector extends StatefulWidget {
  final void Function(DateTime) onMonthChanged;

  const MonthSelector({super.key, required this.onMonthChanged});

  @override
  State<MonthSelector> createState() => _MonthSelectorState();
}

class _MonthSelectorState extends State<MonthSelector> {
  DateTime _currentDate = DateTime.now();

  void _changeMonth(int offset) {
    setState(() {
      _currentDate = _currentDate.addMonths(offset);
    });
    widget.onMonthChanged(_currentDate);
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final String dateText = DateFormat('MMMM yyyy', locale).format(_currentDate).toTitleCase();
    return Padding(
      padding: const EdgeInsets.only(left: 90.0, right: 90.0),
      child: Row(
        children: [
          IconButton(icon: const Icon(Icons.chevron_left), onPressed: () => _changeMonth(-1)),
          Expanded(child: Center(child: Text(dateText))),
          IconButton(icon: const Icon(Icons.chevron_right), onPressed: () => _changeMonth(1)),
        ],
      ),
    );
  }
}
