import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/utils/app_colors.dart';

class IntroSliderPageIndicator extends StatelessWidget {
  const IntroSliderPageIndicator({
    super.key,
    required this.controller,
    required this.length,
  });

  final PageController controller;

  final int length;

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: controller,
    builder: (context, _) => IntroSliderIndicator(
      currentIndex: controller.hasClients ? controller.page?.round() ?? 0 : 0,
      length: length,
    ),
  );
}

class IntroSliderIndicator extends StatelessWidget {
  const IntroSliderIndicator({
    super.key,
    required this.currentIndex,
    required this.length,
  });

  final int currentIndex;

  final int length;

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: List.generate(
      length,
      (index) => AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        width: currentIndex == index ? 25 : 10,
        height: 10.h,
        decoration: BoxDecoration(
          color: currentIndex == index
              ? AppColors.introSliderCircleColor
              : AppColors.white,
          border: Border.all(width: 1.w, color: AppColors.darkGreenColor),
          borderRadius: BorderRadius.circular(20.r),
        ),
      ),
    ),
  );
}
