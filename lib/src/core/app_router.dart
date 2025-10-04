import 'package:boilerplate/src/features/dashboard/presentation/screens/faq_screen.dart';

import 'package:boilerplate/src/shared/utils/app_routes.dart';
import 'package:go_router/go_router.dart';

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
import '../features/dashboard/presentation/screens/phone_details_screen.dart';

import '../features/dashboard/presentation/screens/top_selling_phone_screen.dart';
import '../features/introslider/screens/introslider_screen.dart';
import '../features/questionaire/presentation/screen/defects_selection_screen.dart';
import '../features/questionaire/presentation/screen/dents_selection_screen.dart';

import '../features/questionaire/presentation/screen/device_value_screen.dart';

import '../features/questionaire/presentation/screen/imei_screen.dart';

import '../features/questionaire/presentation/screen/missing_panel_selection_screen.dart';
import '../features/questionaire/presentation/screen/product_condition_screen.dart';
import '../features/questionaire/presentation/screen/product_question_answer_screen.dart';
import '../features/questionaire/presentation/screen/scratch_selection_screen.dart';
import '../features/questionaire/presentation/screen/additional_issues_screen.dart';
import '../features/questionaire/presentation/screen/available_accessories_screen.dart';
import '../features/questionaire/presentation/screen/warranty_selection_screen.dart';
import '../features/questionaire/presentation/screen/upload_device_image_screen.dart';
import '../features/orders/presentations/screen/order_history_screen.dart';
import '../features/splash/screens/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/splash',
  routes: [
    GoRoute(path: '/splash', builder: (context, state) => const SplashScreen()),

    GoRoute(
      path: '/dashboard',
      builder: (context, state) => DashboardScreen(),
      routes: [
        GoRoute(path: 'faqs', builder: (context, state) => const FaqScreen()),
      ],
    ),
    GoRoute(
      path: AppRoutes.auth,
      builder: (context, state) => const LoginScreen(),
      routes: [
        GoRoute(
          path: 'forgot-password',
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
        GoRoute(
          path: 'reset-password',
          builder: (context, state) {
            final email =
                (state.extra as String?) ??
                (throw AppRoutingError.missingParameter(
                  'email',
                  'reset-password',
                ));

            return ResetPasswordScreen(email: email);
          },
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

      builder: (context, state) =>
          ExploreProductsScreen(brandId: state.pathParameters['brandId']!),
    ),
    GoRoute(
      path: '/phone-details/:modelId',
      builder: (context, state) =>
          PhoneDetailsScreen(modelId: state.pathParameters['modelId']!),
    ),
    GoRoute(
      path: '/top-selling-phones',
      builder: (context, state) => TopSellingPhoneScreen(),
    ),
    GoRoute(path: '/imei-screen', builder: (context, state) => ImeiScreen()),
    GoRoute(
      path: '/product-question-answer',
      builder: (context, state) => ProductQuestionAnswerScreen(),
    ),
    GoRoute(
      path: '/product-condition-screen',
      builder: (context, state) => ProductConditionScreen(),
    ),
    GoRoute(
      path: '/scratch-selection-screen',
      builder: (context, state) => ScratchSelectionScreen(),
    ),
    GoRoute(
      path: '/defects-selection-screen',
      builder: (context, state) => DefectsSelectionScreen(),
    ),
    GoRoute(
      path: '/dents-selection-screen',
      builder: (context, state) => DentsSelectionScreen(),
    ),
    GoRoute(
      path: '/missing-panel-selection-screen',
      builder: (context, state) => MissingPanelSelectionScreen(),
    ),
    GoRoute(
      path: '/additional-issues-screen',
      builder: (context, state) => AdditionalIssuesScreen(),
    ),
    GoRoute(
      path: '/available-accessories-screen',
      builder: (context, state) => AvailableAccessoriesScreen(),
    ),
    GoRoute(
      path: '/warranty-selection-screen',
      builder: (context, state) => WarrantySelectionScreen(),
    ),
    GoRoute(
      path: '/upload-device-image-screen',
      builder: (context, state) => UploadDeviceImageScreen(),
    ),
    GoRoute(
      path: '/order-history-screen',
      builder: (context, state) => OrderHistoryScreen(),
    ),
    GoRoute(
      path: '/device-value-screen',
      builder: (context, state) => DeviceValueScreen(),
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

class AppRoutingError extends Error {
  AppRoutingError(this.message);

  AppRoutingError.missingParameter(String paramName, String route)
    : message = 'Missing required parameter "$paramName" for route "$route"';

  final String message;

  @override
  String toString() => 'AppRoutingError: $message';
}
