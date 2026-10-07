/// For testing login/signup pages
library;

class AuthService {
  // Simulated user database (in-memory)
  static final List<Map<String, String>> _users = [
    {
      'id': '1',
      'name': 'Test User',
      'email': 'test@example.com',
      'password': 'password123',
    },
  ];

  // Current logged-in user
  static Map<String, String>? _currentUser;

  /// Login with email and password
  /// Test credentials: test@example.com / password123
  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 1500));

      // Find user
      final user = _users.firstWhere(
        (u) => u['email'] == email.trim() && u['password'] == password,
        orElse: () => {},
      );

      if (user.isEmpty) {
        throw 'Invalid email or password';
      }

      _currentUser = user;

      return {
        'success': true,
        'user': {
          'id': user['id'],
          'email': user['email'],
          'name': user['name'],
        },
      };
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Register with email and password
  static Future<Map<String, dynamic>> signup({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      // Simulate network delay
      await Future.delayed(const Duration(milliseconds: 1500));

      // Check if user exists
      if (_users.any((u) => u['email'] == email.trim())) {
        throw 'Email is already registered';
      }

      // Create new user
      final newUser = {
        'id': DateTime.now().millisecondsSinceEpoch.toString(),
        'name': name,
        'email': email.trim(),
        'password': password,
      };

      _users.add(newUser);
      _currentUser = newUser;

      return {
        'success': true,
        'user': {
          'id': newUser['id'],
          'email': newUser['email'],
          'name': newUser['name'],
        },
      };
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  /// Logout
  static Future<void> logout() async {
    _currentUser = null;
  }

  /// Get current logged-in user
  static Map<String, String>? getCurrentUser() {
    return _currentUser;
  }

  /// Check if user is logged in
  static bool isUserLoggedIn() {
    return _currentUser != null;
  }

  /// Reset password (placeholder)
  static Future<void> resetPassword(String email) async {
    await Future.delayed(const Duration(milliseconds: 1000));
    if (!_users.any((u) => u['email'] == email.trim())) {
      throw 'Email not found';
    }
    print('✅ Reset email sent to: $email');
  }

  /// Get all registered users (for testing/debugging)
  static List<Map<String, String>> getAllUsers() {
    return _users;
  }

  /// Clear all users (for testing/debugging)
  static void clearAllUsers() {
    _users.clear();
  }

  /// Add test user (for testing/debugging)
  static void addTestUser({
    required String name,
    required String email,
    required String password,
  }) {
    _users.add({
      'id': DateTime.now().millisecondsSinceEpoch.toString(),
      'name': name,
      'email': email,
      'password': password,
    });
  }
}
