import 'package:boilerplate/src/features/dashboard/domain/entities/user_review.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_assets.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserReviewCard extends StatelessWidget {
  const UserReviewCard(this.review, {super.key});

  final UserReview review;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5.w),
      child: Column(
        children: [
          Container(
            height: 174.h,
            width: 194.w,
            padding: EdgeInsets.all(18.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0D2D2E39),
                  offset: Offset(2, 4),
                  blurRadius: 10,
                  spreadRadius: 2, // spread
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(AppAssets.quote, width: 24.w, height: 24.h),
                SizedBox(height: 18.h),
                RegularText(
                  textAlign: TextAlign.center,
                  textSize: 12.sp,
                  maxLines: 4,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.orderTitleColor,
                  textOverflow: TextOverflow.ellipsis,
                  text: review.message,
                ),
                SizedBox(height: 8.h),
                RegularText(
                  textAlign: TextAlign.center,
                  textSize: 12.sp,
                  maxLines: 1,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.orderTitleColor,
                  textOverflow: TextOverflow.ellipsis,
                  text: '~${review.username}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
