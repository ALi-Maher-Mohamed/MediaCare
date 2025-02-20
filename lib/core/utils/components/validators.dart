class AppValidators {
  AppValidators._(); // Private constructor to prevent instantiation

  /// Validates an email format.
  static String? validateEmail(String? value) {
    if (value == null || value.trim().isEmpty) return 'This field is required';
    final emailRegex =
    RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    if (!emailRegex.hasMatch(value)) return 'Enter a valid email';
    return null;
  }

  /// Validates a password (at least 8 characters, with letters and numbers).
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    if (value.length < 8) return 'Password must be at least 8 characters';
    // if (!RegExp(r'^(?=.*[a-zA-Z])(?=.*\d)').hasMatch(value)) {
    //   return 'Password must contain letters and numbers';
    // }
    return null;
  }

  /// Validates password confirmation.
  static String? validateConfirmPassword(String? val, String? password) {
    print('Password: $password, Confirm Password: $val');
    if (val == null || val.trim().isEmpty) {
      return 'This field is required';
    }
    if (password == null || password.trim().isEmpty) {
      return 'Password field is empty';
    }
    if (val.trim() != password.trim()) {
      return 'Passwords do not match';
    }
    return null;
  }

  /// Validates a username (only letters, numbers, dots, and dashes allowed).
  static String? validateUsername(String? value) {
    if (value == null || value.isEmpty) return 'This field is required';
    if (!RegExp(r'^[a-zA-Z0-9.-]+$').hasMatch(value))
      return 'Enter a valid username';
    return null;
  }

  /// Validates a full name (ensures it's not empty).
  static String? validateFullName(String? value) {
    return (value == null || value.trim().isEmpty)
        ? 'This field is required'
        : null;
  }

  /// Validates a phone number (must be exactly 11 digits).
  static String? validatePhoneNumber(String? value) {
    if (value == null || value.trim().isEmpty) return 'This field is required';
    if (!RegExp(r'^\d{11}$').hasMatch(value))
      return 'Enter a valid 11-digit phone number';
    return null;
  }
}
