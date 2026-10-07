/// Helper class for form validation
class Validators {
  /// Validate email format
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  /// Validate phone number (basic)
  static String? validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }

    if (value.length < 8) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  /// Validate password strength
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }

    return null;
  }

  /// Validate non-empty field
  static String? validateRequired(String? value, String fieldName) {
    if (value == null || value.isEmpty) {
      return '$fieldName is required';
    }

    return null;
  }

  /// Validate minimum length
  static String? validateMinLength(String? value, int minLength) {
    if (value == null || value.isEmpty) {
      return 'This field is required';
    }

    if (value.length < minLength) {
      return 'Minimum $minLength characters required';
    }

    return null;
  }

  /// Validate maximum length
  static String? validateMaxLength(String? value, int maxLength) {
    if (value != null && value.length > maxLength) {
      return 'Maximum $maxLength characters allowed';
    }

    return null;
  }

  /// Validate URL format
  static String? validateUrl(String? value) {
    if (value == null || value.isEmpty) {
      return 'URL is required';
    }

    try {
      Uri.parse(value);
      if (!value.startsWith('http://') && !value.startsWith('https://')) {
        return 'URL must start with http:// or https://';
      }
      return null;
    } catch (e) {
      return 'Please enter a valid URL';
    }
  }

  /// Validate company name
  static String? validateCompanyName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Company name is required';
    }

    if (value.length < 2) {
      return 'Company name must be at least 2 characters';
    }

    return null;
  }

  /// Validate position name
  static String? validatePosition(String? value) {
    if (value == null || value.isEmpty) {
      return 'Position is required';
    }

    if (value.length < 2) {
      return 'Position must be at least 2 characters';
    }

    return null;
  }

  /// Validate location
  static String? validateLocation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Location is required';
    }

    if (value.length < 2) {
      return 'Please enter a valid location';
    }

    return null;
  }

  /// Validate date is not in the past
  static String? validateFutureDate(DateTime? date) {
    if (date == null) {
      return 'Date is required';
    }

    if (date.isBefore(DateTime.now())) {
      return 'Date cannot be in the past';
    }

    return null;
  }

  /// Validate date is not in the future
  static String? validatePastDate(DateTime? date) {
    if (date == null) {
      return 'Date is required';
    }

    if (date.isAfter(DateTime.now())) {
      return 'Date cannot be in the future';
    }

    return null;
  }
}
