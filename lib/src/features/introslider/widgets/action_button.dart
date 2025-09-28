import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/utils/app_texts.dart';
import '../../../shared/widgets/animated_button.dart';

class IntroSliderActionButton extends StatelessWidget {
  const IntroSliderActionButton({
    super.key,
    required this.controller,
    required this.onFinished,
    required this.length,
  });

  final PageController controller;
  final VoidCallback onFinished;

  final int length;

  bool get isLastPage => controller.page?.round() == length - 1;

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: controller,
    builder: (context, _) => Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: SizedBox(
        height: 45.h,
        child: AnimatedButton(
          onPressed: () {
            if (isLastPage) {
              onFinished();
              return;
            }
            controller.nextPage(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeInOut,
            );
          },
          label: isLastPage ? AppTexts.letsStart : AppTexts.next,
          fontSize: 12.sp,
        ),
      ),
    ),
  );
}
