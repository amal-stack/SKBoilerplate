import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../shared/themes/text.dart';
import '../../../shared/utils/app_colors.dart';
import '../models/page_data.dart';

class IntroSliderPage extends StatelessWidget {
  const IntroSliderPage({super.key, required this.page});

  final IntroSliderPageData page;

  @override
  Widget build(BuildContext context) => Padding(
    padding: EdgeInsets.all(24.r),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 30.h),
        //   Expanded(
        Image.asset(
          page.imageAsset,
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
          text: page.title,
        ),
        SizedBox(height: 10.h),
        RegularText(
          textSize: 14.sp,
          textAlign: TextAlign.center,
          maxLines: 2,
          fontWeight: FontWeight.w500,
          textColor: AppColors.borderBlack,
          textOverflow: TextOverflow.ellipsis,
          text: page.subtitle,
        ),
      ],
    ),
  );
}
