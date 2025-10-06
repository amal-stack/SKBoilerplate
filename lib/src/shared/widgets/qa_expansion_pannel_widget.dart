import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QaExpansionPanelWidget extends StatelessWidget {
  final String title; // main title
  final bool isExpanded;
  final VoidCallback onTap;

  // Submitted answers (could come from API)
  final Map<String, String> submittedAnswers;

  const QaExpansionPanelWidget({
    super.key,
    required this.title,
    required this.isExpanded,
    required this.onTap,
    required this.submittedAnswers,
  });

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
            /// Header Row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: RegularText(
                    textAlign: TextAlign.start,
                    textSize: 12.sp,
                    maxLines: 2,
                    fontWeight: FontWeight.w600,
                    textColor: AppColors.borderBlack,
                    textOverflow: TextOverflow.ellipsis,
                    text: title,
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

            /// Expanded Content
            if (isExpanded) SizedBox(height: 10.h),
            if (isExpanded)
              ...submittedAnswers.keys.map((question) {
                final answer = submittedAnswers[question];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          question,
                          style: TextStyle(
                            fontSize: 13.sp,
                            color: AppColors.borderBlack,
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "YES",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: answer == "YES"
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                          SizedBox(width: 8.w),
                          Text(
                            "NO",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: answer == "NO"
                                  ? Colors.green
                                  : Colors.grey,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                );
              }),
          ],
        ),
      ),
    );
  }
}
