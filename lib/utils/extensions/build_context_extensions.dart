import 'package:flutter/material.dart';
import '../constants/colors.dart';

/// Extension methods for BuildContext - for easy access to theme and screen info
extension BuildContextExtensions on BuildContext {
  // ===== THEME & TEXT STYLES =====

  /// Get text theme
  TextTheme get textTheme => Theme.of(this).textTheme;

  /// Get display large
  TextStyle? get displayLarge => textTheme.displayLarge;

  /// Get display medium
  TextStyle? get displayMedium => textTheme.displayMedium;

  /// Get display small
  TextStyle? get displaySmall => textTheme.displaySmall;

  /// Get headline large
  TextStyle? get headlineLarge => textTheme.headlineLarge;

  /// Get headline medium
  TextStyle? get headlineMedium => textTheme.headlineMedium;

  /// Get headline small
  TextStyle? get headlineSmall => textTheme.headlineSmall;

  /// Get title large
  TextStyle? get titleLarge => textTheme.titleLarge;

  /// Get title medium
  TextStyle? get titleMedium => textTheme.titleMedium;

  /// Get title small
  TextStyle? get titleSmall => textTheme.titleSmall;

  /// Get body large
  TextStyle? get bodyLarge => textTheme.bodyLarge;

  /// Get body medium
  TextStyle? get bodyMedium => textTheme.bodyMedium;

  /// Get body small
  TextStyle? get bodySmall => textTheme.bodySmall;

  /// Get label large
  TextStyle? get labelLarge => textTheme.labelLarge;

  /// Get label medium
  TextStyle? get labelMedium => textTheme.labelMedium;

  /// Get label small
  TextStyle? get labelSmall => textTheme.labelSmall;

  // ===== COLORS =====

  /// Check if dark mode is enabled
  bool get isDarkMode => Theme.of(this).brightness == Brightness.dark;

  /// Get primary color
  Color get primaryColor => Theme.of(this).primaryColor;

  /// Get scaffold background color
  Color get scaffoldBackgroundColor => Theme.of(this).scaffoldBackgroundColor;

  /// Get card color
  Color get cardColor => Theme.of(this).cardColor;

  /// Get divider color
  Color get dividerColor => Theme.of(this).dividerColor;

  /// Get primary text color
  Color get textPrimary =>
      isDarkMode ? AppColors.textPrimary : AppColors.textPrimary;

  /// Get secondary text color
  Color get textSecondary =>
      isDarkMode ? AppColors.textSecondary : AppColors.textSecondary;

  // ===== SCREEN SIZE & MEDIA QUERY =====

  /// Get screen width
  double get screenWidth => MediaQuery.of(this).size.width;

  /// Get screen height
  double get screenHeight => MediaQuery.of(this).size.height;

  /// Get screen size
  Size get screenSize => MediaQuery.of(this).size;

  /// Check if device is in landscape
  bool get isLandscape =>
      MediaQuery.of(this).orientation == Orientation.landscape;

  /// Check if device is in portrait
  bool get isPortrait =>
      MediaQuery.of(this).orientation == Orientation.portrait;

  /// Get device pixel ratio
  double get devicePixelRatio => MediaQuery.of(this).devicePixelRatio;

  /// Get bottom padding (safe area)
  double get bottomPadding => MediaQuery.of(this).padding.bottom;

  /// Get top padding (notch/status bar)
  double get topPadding => MediaQuery.of(this).padding.top;

  /// Get safe area
  EdgeInsets get safePadding => MediaQuery.of(this).padding;

  /// Get safe area viewinsets (keyboard height, etc.)
  EdgeInsets get viewInsets => MediaQuery.of(this).viewInsets;

  /// Get keyboard height
  double get keyboardHeight => MediaQuery.of(this).viewInsets.bottom;

  /// Check if keyboard is visible
  bool get isKeyboardVisible => keyboardHeight > 0;

  // ===== RESPONSIVE HELPERS =====

  /// Check if screen is small (mobile)
  /// Usually width < 600
  bool get isSmallScreen => screenWidth < 600;

  /// Check if screen is medium (tablet)
  /// Usually 600 <= width < 1200
  bool get isMediumScreen => screenWidth >= 600 && screenWidth < 1200;

  /// Check if screen is large (desktop)
  /// Usually width >= 1200
  bool get isLargeScreen => screenWidth >= 1200;

  /// Get responsive padding based on screen width
  EdgeInsets get responsivePadding {
    if (isSmallScreen) {
      return const EdgeInsets.all(12);
    } else if (isMediumScreen) {
      return const EdgeInsets.all(16);
    } else {
      return const EdgeInsets.all(24);
    }
  }

  /// Get responsive font size
  double responsiveFontSize(double baseSize) {
    if (isSmallScreen) {
      return baseSize * 0.9;
    } else if (isMediumScreen) {
      return baseSize;
    } else {
      return baseSize * 1.1;
    }
  }

  // ===== NAVIGATION & DIALOGS =====

  /// Push to named route
  Future<dynamic> pushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamed(routeName, arguments: arguments);
  }

  /// Push replacement named route
  Future<dynamic> pushReplacementNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this)
        .pushReplacementNamed(routeName, arguments: arguments);
  }

  /// Pop current screen
  void pop<T>([T? result]) => Navigator.of(this).pop(result);

  /// Pop until predicate
  void popUntil(bool Function(Route<dynamic>) predicate) {
    Navigator.of(this).popUntil(predicate);
  }

  /// Pop all and push named
  Future<dynamic> popAllAndPushNamed(String routeName, {Object? arguments}) {
    return Navigator.of(this).pushNamedAndRemoveUntil(
      routeName,
      (route) => false,
      arguments: arguments,
    );
  }

  /// Show snack bar
  void showSnackBar(
    String message, {
    Duration duration = const Duration(seconds: 2),
    SnackBarAction? action,
  }) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: duration,
        action: action,
      ),
    );
  }

  /// Show error snack bar
  void showErrorSnackBar(String message) {
    showSnackBar(
      message,
      action: SnackBarAction(label: 'Close', onPressed: () {}),
    );
  }

  /// Show success snack bar
  void showSuccessSnackBar(String message) {
    showSnackBar(message);
  }

  /// Show simple dialog
  Future<T?> showSimpleDialog<T>({
    required String title,
    required String message,
    String? positiveButtonText,
    String? negativeButtonText,
  }) {
    return showDialog<T>(
      context: this,
      builder: (_) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          if (negativeButtonText != null)
            TextButton(
              onPressed: () => Navigator.pop(this),
              child: Text(negativeButtonText),
            ),
          if (positiveButtonText != null)
            TextButton(
              onPressed: () => Navigator.pop(this, true),
              child: Text(positiveButtonText),
            ),
        ],
      ),
    );
  }

  /// Dismiss keyboard
  void dismissKeyboard() {
    FocusScope.of(this).unfocus();
  }
}
