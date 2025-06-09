extension DateTimeExtensions on DateTime {
  DateTime addMonths(int offset) {
    final int totalMonths = (year * 12 + (month - 1)) + offset;
    final int newYear = totalMonths ~/ 12;
    final int newMonth = (totalMonths % 12) + 1;

    final int dayInNewMonth = _lastDayOfMonth(newYear, newMonth);
    final int newDay = day > dayInNewMonth ? dayInNewMonth : day;

    return DateTime(newYear, newMonth, newDay, hour, minute, second, millisecond, microsecond);
  }

  static int _lastDayOfMonth(int year, int month) {
    final beginningOfNextMonth = (month == 12) ? DateTime(year + 1, 1) : DateTime(year, month + 1);
    return beginningOfNextMonth.subtract(const Duration(days: 1)).day;
  }
}
