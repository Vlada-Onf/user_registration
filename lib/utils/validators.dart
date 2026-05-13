class Validators {
  static String? requiredString(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  static String? emailString(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final regex = RegExp(r'^[\w\.-]+@[\w\.-]+\.\w{2,4}$');
    if (!regex.hasMatch(value.trim())) {
      return 'Enter a valid email';
    }
    return null;
  }

  static String? phoneUAString(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null;
    }

    final regex = RegExp(r'^380\d{9}$');
    if (!regex.hasMatch(value.trim())) {
      return 'Phone must be in format 380XXXXXXXXX';
    }
    return null;
  }

  static String? strongPasswordString(String? value) {
    if (value == null || value.isEmpty) {
      return null;
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one digit';
    }

    return null;
  }

  static String? Function(String?) combine(
    List<String? Function(String?)> validators,
  ) {
    return (value) {
      for (final validator in validators) {
        final error = validator(value);
        if (error != null) {
          return error;
        }
      }
      return null;
    };
  }
}