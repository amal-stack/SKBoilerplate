import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    this.onTap,
    required this.color,
    required this.borderColor,
    required this.titleColor,
    required this.title,
    required this.value,
  });

  final VoidCallback? onTap;

  final Color color;

  final Color borderColor;

  final Color titleColor;

  final String title;

  final int value;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 100.w,
      height: 84.h,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(width: 1.w, color: borderColor),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RegularText(
              textAlign: TextAlign.center,
              textSize: 24.sp,
              maxLines: 2,
              fontWeight: FontWeight.bold,
              textColor: titleColor,
              textOverflow: TextOverflow.ellipsis,
              text: "$value",
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 58.h,
                  child: RegularText(
                    textAlign: TextAlign.start,
                    textSize: 9.sp,
                    maxLines: 2,
                    fontWeight: FontWeight.w700,
                    textColor: AppColors.orderTitleColor,
                    textOverflow: TextOverflow.ellipsis,
                    text: title,
                  ),
                ),
                Center(
                  child: Image.asset(
                    "assets/images/right_arrow_black.png",
                    width: 18.w,
                    height: 18.h,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
