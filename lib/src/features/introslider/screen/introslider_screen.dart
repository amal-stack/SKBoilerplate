import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/widgets/animated_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class IntroSlider extends StatefulWidget {
  @override
  State<IntroSlider> createState() => _IntroSliderState();
}

class _IntroSliderState extends State<IntroSlider> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _pages = [
    {
      "image": "assets/images/illustrations_first.png",
      "title": "ADD PRODUCT DETAILS",
      "subtitle":
          "Enter the phone’s brand, model and condition to begin the process",
    },
    {
      "image": "assets/images/illustrations_second.png",
      "title": "EXCHANGE YOUR DEVICE",
      "subtitle":
          "Handover the device securely at the scheduled pickup or drop off",
    },
    {
      "image": "assets/images/illustrations_third.png",
      "title": "GET PAID INSTANTLY",
      "subtitle":
          "Receive your payment instantly once the exchange is complete",
    },
  ];

  @override
  void initState() {
    super.initState();
    // Change status bar color only for this screen
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: AppColors.black, // your desired color
        statusBarIconBrightness: Brightness.dark, // icons color
        statusBarBrightness: Brightness.dark, // for iOS
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (index) {
                  setState(() => _currentIndex = index);
                },
                itemCount: _pages.length,
                itemBuilder: (_, index) {
                  return Padding(
                    padding: EdgeInsets.all(24.r),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 30.h),
                        //   Expanded(
                        Image.asset(
                          _pages[index]['image']!,
                          fit: BoxFit.contain,
                          width: 320,
                          height: 400,
                        ),
                        //   ),
                        SizedBox(height: 30.h),
                        RegularText(
                          textSize: 20.sp,
                          maxLines: 2,
                          fontWeight: FontWeight.w700,
                          textColor: AppColors.borderBlack,
                          textOverflow: TextOverflow.ellipsis,
                          text: _pages[index]['title']!,
                        ),
                        SizedBox(height: 10.h),
                        RegularText(
                          textSize: 14.sp,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          fontWeight: FontWeight.w500,
                          textColor: AppColors.borderBlack,
                          textOverflow: TextOverflow.ellipsis,
                          text: _pages[index]['subtitle']!,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _pages.length,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentIndex == index ? 25 : 10,
                  height: 10.h,
                  decoration: BoxDecoration(
                    color:
                        _currentIndex == index
                            ? AppColors.introSliderCircleColor
                            : AppColors.white,
                    border: Border.all(
                      width: 1.w,
                      color: AppColors.darkGreenColor,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
              ),
            ),

            SizedBox(height: 30.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: SizedBox(
                height: 45.h,
                child: AnimatedButton(
                  disableButton: false,
                  isLoading: false,
                  onPressed: () {
                    if (_currentIndex == _pages.length - 1) {
                      context.go('/login');
                    } else {
                      _controller.nextPage(
                        duration: const Duration(milliseconds: 400),
                        curve: Curves.easeInOut,
                      );
                    }
                  },
                  label:
                      _currentIndex == _pages.length - 1
                          ? AppTexts.letsStart
                          : AppTexts.next,
                  fontSize: 12.sp,
                  isSmallButton: false,
                ),
              ),
            ),
            SizedBox(height: 50.h),
          ],
        ),
      ),
    );
  }
}
