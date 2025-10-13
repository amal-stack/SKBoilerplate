import 'package:boilerplate/src/features/auth/presentation/screens/verify_otp_screen.dart';
import 'package:boilerplate/src/features/dashboard/presentation/screens/faq_screen.dart';
import 'package:boilerplate/src/features/products/presentation/screens/phone_details_screen.dart';
import 'package:boilerplate/src/features/questionaire/domain/entities/device_grade.dart';
import 'package:boilerplate/src/features/questionaire/presentation/screen/questionnaire_screen.dart';

import 'package:go_router/go_router.dart';
import 'package:meta/meta.dart';

import '../features/auth/presentation/screens/forgot_password_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/reset_password_screen.dart';
import '../features/auth/presentation/screens/success_screen.dart';
import '../features/brands/presentation/screens/brands_screen.dart';
import '../features/dashboard/presentation/screens/dashboard_screen.dart';

import '../features/kyc/presentation/screen/kyc_details_screen.dart';
import '../features/kyc/presentation/screen/order_success_screen.dart';
import '../features/kyc/presentation/screen/phone_number_verification.dart';
import '../features/kyc/presentation/screen/phone_verification_success_screen.dart';
import '../features/kyc/presentation/screen/upload_document_screen.dart';
import '../features/kyc/presentation/screen/upload_invoice_screen.dart';
import '../features/orders/presentations/screen/completed_order_details_screen.dart';
import '../features/orders/presentations/screen/pending_order_details_screen.dart';
import '../features/products/presentation/screens/explore_products_screen.dart';

import '../features/dashboard/presentation/screens/top_selling_phone_screen.dart';
import '../features/introslider/screens/introslider_screen.dart';

import '../features/questionaire/presentation/screen/device_value_screen.dart';

import '../features/questionaire/presentation/screen/imei_screen.dart';

import '../features/orders/presentations/screen/order_history_screen.dart';
import '../features/splash/screens/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/', redirect: (context, state) => '/splash'),
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),

    GoRoute(
      path: '/dashboard',
      builder: (context, state) => DashboardScreen(),
      routes: [
        GoRoute(path: 'faqs', builder: (context, state) => const FaqScreen()),
      ],
    ),
    GoRoute(
      path: AppRoutes.auth.fullPath,
      builder: (context, state) => const LoginScreen(),
      routes: [
        GoRoute(
          path: 'forgot-password',
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
        GoRoute(
          path: 'verify-otp',
          builder: (context, state) =>
              VerifyOtpScreen(email: AppRouter.extra<String>(state)),
        ),
        GoRoute(
          path: 'reset-password',
          builder: (context, state) => ResetPasswordScreen(
            email: AppRouter.extraMapValue<String>(state, 'email'),
            code: AppRouter.extraMapValue<String>(state, 'code'),
          ),
        ),
        GoRoute(
          path: 'success-screen',
          builder: (context, state) => const SuccessScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/introslider-screen',
      builder: (context, state) => IntroSliderScreen(),
    ),
    GoRoute(path: '/brands', builder: (context, state) => BrandsScreen()),
    GoRoute(
      path: '/explore-brands/:brandId',

      builder: (context, state) => ExploreProductsScreen(
        brandId: AppRouter.pathParameter<String>(state, 'brandId'),
      ),
    ),
    GoRoute(
      path: '/phone-details/:modelId',
      builder: (context, state) => PhoneDetailsScreen(
        modelId: AppRouter.pathParameter<String>(state, 'modelId'),
      ),
    ),
    GoRoute(
      path: '/top-selling-phones',
      builder: (context, state) => TopSellingPhoneScreen(),
    ),
    GoRoute(
      path: '/imei/:deviceId',
      builder: (context, state) => ImeiScreen(
        deviceId: AppRouter.pathParameter<String>(state, 'deviceId'),
      ),
    ),
    GoRoute(
      path: '/questionnaire/:quoteId',
      builder: (context, state) => QuestionnaireScreen(
        quoteId: AppRouter.pathParameter<String>(state, 'quoteId'),
      ),
    ),
    // GoRoute(
    //   path: '/product-question-answer',
    //   builder: (context, state) => DeviceFunctionalityScreen(),
    // ),
    // GoRoute(
    //   path: '/product-condition-screen',
    //   builder: (context, state) => ProductConditionScreen(),
    // ),
    // GoRoute(
    //   path: '/scratch-selection-screen',
    //   builder: (context, state) => ScratchSelectionPage(),
    // ),
    // GoRoute(
    //   path: '/defects-selection-screen',
    //   builder: (context, state) => DisplayDefectsPage(),
    // ),
    // GoRoute(
    //   path: '/dents-selection-screen',
    //   builder: (context, state) => BodyDefectsPage(),
    // ),
    // GoRoute(
    //   path: '/missing-panel-selection-screen',
    //   builder: (context, state) => PanelDefectsPage(),
    // ),
    // GoRoute(
    //   path: '/additional-issues-screen',
    //   builder: (context, state) => AdditionalIssuesPage(),
    // ),
    // GoRoute(
    //   path: '/available-accessories-screen',
    //   builder: (context, state) => AvailableAccessoriesPage(),
    // ),
    // GoRoute(
    //   path: '/warranty-selection-screen',
    //   builder: (context, state) => WarrantySelectionPage(),
    // ),
    // GoRoute(
    //   path: '/upload-device-image-screen',
    //   builder: (context, state) => UploadDeviceImagePage(),
    // ),
    GoRoute(
      path: '/order-history-screen',
      builder: (context, state) => OrderHistoryScreen(),
    ),
    GoRoute(
      path: '/device-value',
      builder: (context, state) => DeviceValueScreen(
        result: AppRouter.extra<DeviceAssessmentResult>(state),
      ),
    ),
    GoRoute(
      path: '/phone-number-verification-screen',
      builder: (context, state) => PhoneNumberVerification(),
    ),
    GoRoute(
      path: '/kyc-details-screen',
      builder: (context, state) => KycDetailsScreen(),
    ),
    GoRoute(
      path: '/phone-number-verification-success-screen',
      builder: (context, state) => PhoneVerificationSuccessScreen(),
    ),
    GoRoute(
      path: '/upload-document-screen',
      builder: (context, state) => UploadDocumentScreen(),
    ),
    GoRoute(
      path: '/upload-invoice-screen',
      builder: (context, state) => UploadInvoiceScreen(),
    ),
    GoRoute(
      path: '/order-success-screen',
      builder: (context, state) => OrderSuccessScreen(),
    ),
    GoRoute(
      path: '/pending-order-screen',
      builder: (context, state) => PendingOrderDetailsScreen(),
    ),
    GoRoute(
      path: '/completed-order-details-screen',
      builder: (context, state) => CompletedOrderDetailsScreen(),
    ),
  ],
);

abstract final class AppRouter {
  static T pathParameter<T>(GoRouterState state, String name) =>
      switch (state.pathParameters[name]) {
        T value? => value,
        _ => throw AppRoutingError.pathParameter(name, state.fullPath),
      };

  static T queryParameter<T>(GoRouterState state, String name) =>
      switch (state.uri.queryParameters[name]) {
        T value? => value,
        _ => throw AppRoutingError.queryParameter(name, state.fullPath),
      };

  static T extra<T>(GoRouterState state) => switch (state.extra) {
    T value? => value,
    _ => throw AppRoutingError.extra('extra', state.fullPath),
  };

  static T extraMapValue<T>(GoRouterState state, String key) =>
      switch (state.extra) {
        Map<String, dynamic> map when map[key] is T => map[key] as T,
        _ => throw AppRoutingError.extra(key, state.fullPath),
      };
}

class AppRoutingError extends Error {
  AppRoutingError(this.message);

  AppRoutingError.pathParameter(String paramName, [String? route])
    : message =
          'Path parameter "$paramName" was either missing or of the wrong type '
          '${route != null ? ' for route "$route"' : ''}';

  AppRoutingError.queryParameter(String paramName, [String? route])
    : message =
          'Query parameter "$paramName" was either missing or of the wrong type '
          '${route != null ? ' for route "$route"' : ''}';

  AppRoutingError.extra(String name, [String? route])
    : message =
          'Extra data "$name" was either missing or of the wrong type '
          '${route != null ? ' for route "$route"' : ''}';

  final String message;

  @override
  String toString() => 'AppRoutingError: $message';
}

@immutable
class AppRoute {
  const AppRoute(this.path, {this.name, this.parent});

  /// Creates a route where the [path] is derived from the [name].
  const AppRoute.simple(String this.name, {this.parent}) : path = name;

  const AppRoute.root({this.name}) : path = '/', parent = null;

  final String path;

  final String? name;

  final AppRoute? parent;

  String get fullPath =>
      parent != null ? '${parent!.fullPath}/$path' : '/$path';
}

abstract final class AppRoutes {
  static const AppRoute auth = AppRoute.simple('auth');

  static const AppRoute register = AppRoute.simple('register', parent: auth);

  static const AppRoute resetPassword = AppRoute.simple(
    'reset-password',
    parent: auth,
  );

  static const AppRoute authSuccess = AppRoute.simple(
    'success-screen',
    parent: auth,
  );

  static const AppRoute dashboard = AppRoute.simple('dashboard');

  static const AppRoute faqs = AppRoute.simple('faqs', parent: dashboard);

  static const AppRoute brands = AppRoute.simple('brands');

  static const AppRoute exploreProducts = AppRoute(
    'explore-products/:brandId',
    name: 'explore-products',
    parent: dashboard,
  );

  static const AppRoute phoneDetails = AppRoute(
    'phone-details/:modelId',
    name: 'phone-details',
    parent: dashboard,
  );

  static const AppRoute topSellingPhones = AppRoute.simple(
    'top-selling-phones',
    parent: dashboard,
  );

  static const AppRoute enterImei = AppRoute.simple('imei');

  static const AppRoute productQuestionAnswer = AppRoute.simple(
    'product-question-answer',
  );

  static const AppRoute productConditionScreen = AppRoute.simple(
    'product-condition-screen',
  );

  static const AppRoute scratchSelectionScreen = AppRoute.simple(
    'scratch-selection-screen',
  );

  static const AppRoute defectsSelectionScreen = AppRoute.simple(
    'defects-selection-screen',
  );

  static const AppRoute dentsSelectionScreen = AppRoute.simple(
    'dents-selection-screen',
  );

  static const AppRoute missingPanelSelectionScreen = AppRoute.simple(
    'missing-panel-selection-screen',
  );

  static const AppRoute additionalIssuesScreen = AppRoute.simple(
    'additional-issues-screen',
  );

  static const AppRoute availableAccessoriesScreen = AppRoute.simple(
    'available-accessories-screen',
  );

  static const AppRoute warrantySelectionScreen = AppRoute.simple(
    'warranty-selection-screen',
  );

  static const AppRoute uploadDeviceImageScreen = AppRoute.simple(
    'upload-device-image-screen',
  );

  static const AppRoute orderHistoryScreen = AppRoute.simple(
    'order-history-screen',
  );

  static const AppRoute deviceValueScreen = AppRoute.simple(
    'device-value-screen',
  );

  static const AppRoute phoneNumberVerificationScreen = AppRoute.simple(
    'phone-number-verification-screen',
  );

  static const AppRoute kycDetailsScreen = AppRoute.simple(
    'kyc-details-screen',
  );

  static const AppRoute phoneNumberVerificationSuccessScreen = AppRoute.simple(
    'phone-number-verification-success-screen',
  );

  static const AppRoute uploadDocumentScreen = AppRoute.simple(
    'upload-document-screen',
  );

  static const AppRoute uploadInvoiceScreen = AppRoute.simple(
    'upload-invoice-screen',
  );

  static const AppRoute orderSuccessScreen = AppRoute.simple(
    'order-success-screen',
  );

  static const AppRoute pendingOrderDetailsScreen = AppRoute.simple(
    'pending-order-screen',
  );

  static const AppRoute completedOrderDetailsScreen = AppRoute.simple(
    'completed-order-details-screen',
  );
}
