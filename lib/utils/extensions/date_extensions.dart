/// Extension methods for DateTime
extension DateTimeExtensions on DateTime {
  /// Check if date is today
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Check if date is tomorrow
  bool get isTomorrow {
    final tomorrow = DateTime.now().add(const Duration(days: 1));
    return year == tomorrow.year &&
        month == tomorrow.month &&
        day == tomorrow.day;
  }

  /// Check if date is yesterday
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Check if date is in the past
  bool get isPast => isBefore(DateTime.now());

  /// Check if date is in the future
  bool get isFuture => isAfter(DateTime.now());

  /// Get only date part (no time)
  DateTime get dateOnly => DateTime(year, month, day);

  /// Get start of day (00:00:00)
  DateTime get startOfDay => DateTime(year, month, day);

  /// Get end of day (23:59:59)
  DateTime get endOfDay => DateTime(year, month, day, 23, 59, 59);

  /// Get start of week (Monday)
  DateTime get startOfWeek {
    final difference = weekday - 1;
    return subtract(Duration(days: difference)).startOfDay;
  }

  /// Get end of week (Sunday)
  DateTime get endOfWeek => startOfWeek.add(const Duration(days: 7));

  /// Get start of month
  DateTime get startOfMonth => DateTime(year, month, 1);

  /// Get end of month
  DateTime get endOfMonth => DateTime(year, month + 1, 0, 23, 59, 59);

  /// Get start of year
  DateTime get startOfYear => DateTime(year, 1, 1);

  /// Get end of year
  DateTime get endOfYear => DateTime(year, 12, 31, 23, 59, 59);

  /// Get previous day
  DateTime get previousDay => subtract(const Duration(days: 1));

  /// Get next day
  DateTime get nextDay => add(const Duration(days: 1));

  /// Get day of week name
  String get dayName {
    const days = [
      'Monday',
      'Tuesday',
      'Wednesday',
      'Thursday',
      'Friday',
      'Saturday',
      'Sunday',
    ];
    return days[weekday - 1];
  }

  /// Get short day name (Mon, Tue, etc.)
  String get dayNameShort {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  /// Get month name
  String get monthName {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  /// Get short month name (Jan, Feb, etc.)
  String get monthNameShort {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  /// Get difference in days from now
  int get daysFromNow {
    final now = DateTime.now().startOfDay;
    return difference(now).inDays;
  }

  /// Get difference in days from another date
  int daysDifference(DateTime other) {
    return difference(other).inDays.abs();
  }

  /// Check if in same week as another date
  bool isSameWeek(DateTime other) {
    return startOfWeek == other.startOfWeek;
  }

  /// Check if in same month as another date
  bool isSameMonth(DateTime other) {
    return year == other.year && month == other.month;
  }

  /// Check if in same year as another date
  bool isSameYear(DateTime other) {
    return year == other.year;
  }

  /// Get age from birthday
  int getAge() {
    final today = DateTime.now();
    int age = today.year - year;

    if (month > today.month || (month == today.month && day > today.day)) {
      age--;
    }

    return age;
  }

  /// Check if is leap year
  bool get isLeapYear {
    return (year % 4 == 0 && year % 100 != 0) || (year % 400 == 0);
  }

  /// Get number of days in this month
  int get daysInMonth {
    return DateTime(year, month + 1, 0).day;
  }

  /// Add business days (excluding weekends)
  DateTime addBusinessDays(int days) {
    var current = this;
    var added = 0;

    while (added < days) {
      current = current.add(const Duration(days: 1));
      if (current.weekday < 6) {
        added++;
      }
    }

    return current;
  }
}
