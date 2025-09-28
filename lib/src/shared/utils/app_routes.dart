abstract final class AppRoutes {
  static const String splash = '/splash';
  static const String introSlider = '/intro-slider';

  // Auth Routes
  static const String auth = '/auth';
  static const String register = '$auth/register';
  static const String authSuccess = '$auth/success-screen';
  static const String forgotPassword = '$auth/forgot-password';
  static const String resetPassword = '$auth/reset-password';
  static const String verifyOtp = '$auth/verify-otp';

  // Dashboard Routes
  static const String dashboard = '/dashboard';
  static const String brands = '/brands';
  static const String exploreProducts = '/explore-products';
  static const String phoneDetails = '/phone-details';
  static const String topSellingPhones = '/top-selling-phones';

  // Question Answer Routes
  static const String imeiScreen = '/imei-screen';
  static const String productQuestionAnswer = '/product-question-answer';
  static const String productConditionScreen = '/product-condition-screen';
  static const String scratchSelectionScreen = '/scratch-selection-screen';
  static const String defectsSelectionScreen = '/defects-selection-screen';
  static const String dentsSelectionScreen = '/dents-selection-screen';
  static const String missingPanelSelectionScreen =
      '/missing-panel-selection-screen';
  static const String additionalIssuesScreen = '/additional-issues-screen';
  static const String availableAccessoriesScreen =
      '/available-accessories-screen';
}
