import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/themes/text.dart';
import '../../../../shared/utils/app_colors.dart';
import '../../../../shared/utils/app_images.dart';
import '../../../../shared/utils/app_routes.dart';
import '../../../../shared/widgets/animated_button.dart';

class SuccessBody extends StatelessWidget {
  const SuccessBody({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Image.asset(
        'assets/images/app_theme_icon.png',
        width: 122.w,
        height: 48.h,
      ),
      SizedBox(height: 120.h),
      SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppIcons.success, width: 56.w, height: 56.h),
            SizedBox(height: 30.h),
            RegularText(
              textAlign: TextAlign.center,
              textSize: 18.sp,
              maxLines: 2,
              fontWeight: FontWeight.w600,
              textColor: AppColors.titleBlackColor,
              textOverflow: TextOverflow.ellipsis,
              text: 'Password updated successfully',
            ),
          ],
        ),
      ),
      SizedBox(height: 5.h),
      SizedBox(height: 30.h),
      SizedBox(
        height: 45.h,
        width: double.infinity,
        child: AnimatedButton(
          onPressed: () {
            context.go(AppRoutes.auth);
          },
          label: 'Login now',
          fontSize: 12.sp,
        ),
      ),
    ],
  );
}
