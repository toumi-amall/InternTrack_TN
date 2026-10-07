import 'package:intl/intl.dart';

/// Helper class for currency and number formatting
class CurrencyFormatter {
  /// Format number as currency (USD by default)
  static String formatUSD(double amount) {
    return NumberFormat.currency(symbol: '\$', decimalDigits: 2).format(amount);
  }

  /// Format number as currency (EUR)
  static String formatEUR(double amount) {
    return NumberFormat.currency(symbol: '€', decimalDigits: 2).format(amount);
  }

  /// Format number as currency (GBP)
  static String formatGBP(double amount) {
    return NumberFormat.currency(symbol: '£', decimalDigits: 2).format(amount);
  }

  /// Format number as currency (TND - Tunisian Dinar)
  static String formatTND(double amount) {
    return NumberFormat.currency(symbol: 'د.ت', decimalDigits: 3)
        .format(amount);
  }

  /// Format number as currency with custom locale
  static String formatCurrency(double amount, String locale, String symbol) {
    return NumberFormat.currency(locale: locale, symbol: symbol).format(amount);
  }

  /// Format number with thousands separator
  static String formatNumber(double number) {
    return NumberFormat('#,##0.##').format(number);
  }

  /// Format number as percentage
  static String formatPercentage(double percentage) {
    return NumberFormat.percentPattern().format(percentage);
  }

  /// Format large numbers with K, M, B suffix
  static String formatCompact(double number) {
    if (number >= 1000000000) {
      return '${(number / 1000000000).toStringAsFixed(1)}B';
    } else if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toStringAsFixed(0);
    }
  }

  /// Format salary range
  static String formatSalaryRange(double minSalary, double maxSalary) {
    return '${formatUSD(minSalary)} - ${formatUSD(maxSalary)}';
  }

  /// Parse currency string to double
  static double? parseCurrency(String value) {
    try {
      // Remove common currency symbols and whitespace
      String cleaned = value.replaceAll(RegExp(r'[^\d.-]'), '').trim();
      return double.parse(cleaned);
    } catch (e) {
      return null;
    }
  }

  /// Format duration in hours to decimal
  static String formatDecimalHours(Duration duration) {
    final hours = duration.inMinutes / 60;
    return hours.toStringAsFixed(2);
  }
}
