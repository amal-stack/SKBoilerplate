import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QnAItem extends StatelessWidget {
  final String question;
  final String answer;
  final bool isExpanded;
  final VoidCallback onTap;

  const QnAItem({
    Key? key,
    required this.question,
    required this.answer,
    required this.isExpanded,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.w),
          border: Border.all(
            width: 1.w,
            color: AppColors.borderBlack.withOpacity(0.10),
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
