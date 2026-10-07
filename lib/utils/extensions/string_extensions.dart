/// Extension methods for String
extension StringExtensions on String {
  /// Capitalize first letter
  /// "hello" -> "Hello"
  String get capitalize =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';

  /// Capitalize all words
  /// "hello world" -> "Hello World"
  String get capitalizeWords {
    return split(' ').map((word) => word.capitalize).join(' ');
  }

  /// Convert to title case
  String get toTitleCase {
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => ' ${match.group(0)}',
    ).capitalize.trim();
  }

  /// Check if string is email
  bool get isEmail {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(this);
  }

  /// Check if string is numeric
  bool get isNumeric => double.tryParse(this) != null;

  /// Check if string is URL
  bool get isUrl {
    try {
      Uri.parse(this);
      return startsWith('http://') || startsWith('https://');
    } catch (e) {
      return false;
    }
  }

  /// Check if string contains only letters
  bool get isAlpha => RegExp(r'^[a-zA-Z]+$').hasMatch(this);

  /// Check if string is alphanumeric
  bool get isAlphaNumeric => RegExp(r'^[a-zA-Z0-9]+$').hasMatch(this);

  /// Remove all whitespace
  String get removeWhitespace => replaceAll(RegExp(r'\s+'), '');

  /// Remove leading and trailing whitespace (trim is built-in)
  // Already available as trim()

  /// Reverse string
  String get reverse => split('').reversed.join('');

  /// Check if palindrome
  bool get isPalindrome {
    final cleaned = removeWhitespace.toLowerCase();
    return cleaned == cleaned.reverse;
  }

  /// Truncate string with ellipsis
  String truncate(int length) {
    if (this.length <= length) return this;
    return '${substring(0, length)}...';
  }

  /// Repeat string n times
  String repeat(int times) => List.filled(times, this).join();

  /// Reverse character order
  String get reversed => split('').reversed.join('');

  /// Convert snake_case to camelCase
  String get toCamelCase {
    final parts = split('_');
    return parts
        .asMap()
        .entries
        .map((entry) => entry.key == 0 ? entry.value : entry.value.capitalize)
        .join();
  }

  /// Convert camelCase to snake_case
  String get toSnakeCase {
    return replaceAllMapped(
      RegExp(r'[A-Z]'),
      (match) => '_${match.group(0)}',
    ).toLowerCase();
  }

  /// Get initials from name
  String get getInitials {
    if (isEmpty) return '';

    final words = split(' ');
    final initials = words.take(2).map((word) => word[0].toUpperCase()).join();

    return initials.isEmpty ? this[0].toUpperCase() : initials;
  }

  /// Check if string contains special characters
  bool get hasSpecialCharacters {
    return RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(this);
  }

  /// Check if string is strong password
  bool get isStrongPassword {
    return length >= 8 &&
        RegExp(r'[A-Z]').hasMatch(this) &&
        RegExp(r'[a-z]').hasMatch(this) &&
        RegExp(r'[0-9]').hasMatch(this) &&
        hasSpecialCharacters;
  }
}
