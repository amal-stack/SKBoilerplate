import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FaqItem extends StatelessWidget {
  const FaqItem({
    super.key,
    required this.question,
    required this.answer,
    required this.index,
    required this.expandedIndex,
    required this.onTap,
  });

  final String question;
  final String answer;
  final int index;
  final int? expandedIndex;
  bool get isExpanded => index == expandedIndex;
  final ValueChanged<int> onTap;

  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(index),
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.w),
          border: Border.all(
            width: 1.w,
            color: AppColors.borderBlack.withValues(alpha: 0.10),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 265.w,
                  child: RegularText(
                    textAlign: TextAlign.start,
                    textSize: 12.sp,
                    maxLines: 2,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.borderBlack,
                    textOverflow: TextOverflow.ellipsis,
                    text: question,
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  color: Colors.grey,
                ),
              ],
            ),
            if (isExpanded) SizedBox(height: 10.h),
            if (isExpanded)
              SizedBox(
                width: 270.w,
                child: RegularText(
                  textAlign: TextAlign.start,
                  textSize: 12.sp,
                  maxLines: 6,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.borderBlack,
                  textOverflow: TextOverflow.ellipsis,
                  text: answer,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
