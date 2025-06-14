class Validator {
  static String? isEmptyOrNull(String? value, String errorMessage) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value != null && value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }
}
