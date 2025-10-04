import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';

import '../../../shared/utils/app_colors.dart';
import '../../../shared/utils/app_images.dart';
import '../../../shared/utils/app_routes.dart';
import '../models/page_data.dart';
import '../widgets/intro_slider.dart';

class IntroSliderScreen extends StatefulWidget {
  const IntroSliderScreen({super.key});

  @override
  State<IntroSliderScreen> createState() => _IntroSliderScreenState();
}

const pages = [
  IntroSliderPageData(
    imageAsset: AppImages.onboarding1,
    title: 'ADD PRODUCT DETAILS',
    subtitle:
        'Enter the phone’s brand, model and condition to begin the process',
  ),
  IntroSliderPageData(
    imageAsset: AppImages.onboarding2,
    title: 'EXCHANGE YOUR DEVICE',
    subtitle:
        'Handover the device securely at the scheduled pickup or drop off',
  ),
  IntroSliderPageData(
    imageAsset: AppImages.onboarding3,
    title: 'GET PAID INSTANTLY',
    subtitle: 'Receive your payment instantly once the exchange is complete',
  ),
];

class _IntroSliderScreenState extends State<IntroSliderScreen> {
  @override
  void initState() {
    super.initState();
    // Change status bar color only for this screen
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: AppColors.black, // your desired color
        statusBarIconBrightness: Brightness.dark, // icons color
        statusBarBrightness: Brightness.dark, // for iOS
      ),
    );
  }

  void _onIntroFinished() {
    context.go(AppRoutes.auth); 
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.white,
    body: SafeArea(
      child: IntroSlider(pages: pages, onFinished: _onIntroFinished),
    ),
  );
}
