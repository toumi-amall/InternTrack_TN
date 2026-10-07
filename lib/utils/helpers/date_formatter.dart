import 'package:intl/intl.dart';

/// Helper class for date formatting
class DateFormatter {
  /// Format date as "Jan 15, 2024"
  static String formatMedium(DateTime date) {
    return DateFormat('MMM dd, yyyy').format(date);
  }

  /// Format date as "January 15, 2024"
  static String formatLong(DateTime date) {
    return DateFormat('MMMM dd, yyyy').format(date);
  }

  /// Format date as "15/01/2024"
  static String formatShort(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  /// Format date as "Jan 15"
  static String formatMonthDay(DateTime date) {
    return DateFormat('MMM dd').format(date);
  }

  /// Format date as "Monday, Jan 15"
  static String formatDayMonthDate(DateTime date) {
    return DateFormat('EEEE, MMM dd').format(date);
  }

  /// Format time as "2:30 PM"
  static String formatTime(DateTime dateTime) {
    return DateFormat('h:mm a').format(dateTime);
  }

  /// Format datetime as "Jan 15, 2024 at 2:30 PM"
  static String formatDateTime(DateTime dateTime) {
    return DateFormat('MMM dd, yyyy \'at\' h:mm a').format(dateTime);
  }

  /// Format date for display in cards (e.g., "Today", "Tomorrow", "Jan 15")
  static String formatRelative(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final yesterday = today.subtract(const Duration(days: 1));

    final dateOnly = DateTime(date.year, date.month, date.day);

    if (dateOnly == today) {
      return 'Today';
    } else if (dateOnly == tomorrow) {
      return 'Tomorrow';
    } else if (dateOnly == yesterday) {
      return 'Yesterday';
    } else {
      return formatMedium(date);
    }
  }

  /// Get month name (e.g., "January")
  static String getMonthName(int month) {
    return DateFormat('MMMM').format(DateTime(2024, month));
  }

  /// Get day name (e.g., "Monday")
  static String getDayName(DateTime date) {
    return DateFormat('EEEE').format(date);
  }

  /// Get week number
  static int getWeekNumber(DateTime date) {
    final first = DateTime(date.year, 1, 1);
    final diff = date.difference(first);
    return ((diff.inDays + first.weekday - 1) / 7).ceil();
  }

  /// Check if date is today
  static bool isToday(DateTime date) {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  /// Check if date is in the past
  static bool isPast(DateTime date) {
    return date.isBefore(DateTime.now());
  }

  /// Check if date is in the future
  static bool isFuture(DateTime date) {
    return date.isAfter(DateTime.now());
  }

  /// Get time difference description (e.g., "2 days ago", "in 3 hours")
  static String getTimeDifference(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inSeconds < 60) {
      return 'just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} hours ago';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays < 30) {
      final weeks = (difference.inDays / 7).floor();
      return '$weeks weeks ago';
    } else {
      return formatMedium(date);
    }
  }
}
