import 'package:boilerplate/src/shared/utils/app_routes.dart';
import 'package:go_router/go_router.dart';

import '../features/auth/presentation/screens/forgot_password_screen.dart';
import '../features/auth/presentation/screens/login_screen.dart';
import '../features/auth/presentation/screens/reset_password_screen.dart';
import '../features/auth/presentation/screens/success_screen.dart';
import '../features/dashboard/presentation/screens/brands_screen.dart';
import '../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../features/dashboard/presentation/screens/explore_products_screen.dart';
import '../features/dashboard/presentation/screens/phone_details_screen.dart';
import '../features/dashboard/presentation/screens/top_selling_phone_screen.dart';
import '../features/introslider/screen/introslider_screen.dart';
import '../features/questionaire/presentation/screen/defects_selection_screen.dart';
import '../features/questionaire/presentation/screen/dents_selection_screen.dart';
import '../features/questionaire/presentation/screen/imel_screen.dart';
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
    GoRoute(path: '/dashboard', builder: (context, state) => DashboardScreen()),
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
            final email = state.extra as String? ?? '';
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
      path: '/explore-brands',
      builder: (context, state) => ExploreProductsScreen(),
    ),
    GoRoute(
      path: '/phone-details',
      builder: (context, state) => PhoneDetailsScreen(),
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
  ],
);
