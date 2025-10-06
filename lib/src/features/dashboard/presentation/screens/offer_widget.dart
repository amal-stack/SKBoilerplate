import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OfferWidget extends StatelessWidget {
  const OfferWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;

  final String title;

  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 75.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        // card background
        borderRadius: BorderRadius.circular(8),
        // optional corner radius
        boxShadow: [
          BoxShadow(
            color: Color(0x0D2D2E39), // #2D2E390D in Flutter ARGB
            offset: Offset(2, 4), // horizontal & vertical offset
            blurRadius: 10, // blur radius
            spreadRadius: 2, // spread radius
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Row(
          children: [
            Image.asset(image, height: 22.h, width: 24.w, fit: BoxFit.contain),
            SizedBox(width: 20.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RegularText(
                  textAlign: TextAlign.end,
                  textSize: 12.sp,
                  maxLines: 1,
                  fontWeight: FontWeight.w700,
                  textColor: AppColors.black,
                  textOverflow: TextOverflow.ellipsis,
                  text: title,
                ),
                SizedBox(height: 5.h),
                RegularText(
                  textAlign: TextAlign.end,
                  textSize: 10.sp,
                  maxLines: 2,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.black,
                  textOverflow: TextOverflow.ellipsis,
                  text: subtitle,
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
