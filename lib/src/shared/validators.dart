class Validators {


  // Check for leading space
  static bool _hasLeadingSpace(String value) {
    return value.startsWith(' ');
  }

  // Validate Email
  static String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (_hasLeadingSpace(value)) {
      return 'Email cannot start with a space';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  // Validate Password
  static String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (_hasLeadingSpace(value)) {
      return 'Password cannot start with a space';
    }
    if (value.length <= 6) {

      return 'Password must be at least 6 characters';
    }
    return null;
  }
  // Validate Mobile
  static String? validateMobileNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Mobile Number is required';
    }
    if (_hasLeadingSpace(value)) {
      return 'Mobile Number cannot start with a space';
    }
    if (value.length < 10) {

      return 'Mobile Number must be at least 10 digit';
    }
    return null;
  }
  // Validate Name
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (_hasLeadingSpace(value)) {
      return 'Name cannot start with a space';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters';
    }
    return null;
  }
}
