import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppCheckBox extends StatelessWidget {
  const AppCheckBox({super.key, this.onTap, required this.isSelected});

  final VoidCallback? onTap;

  final bool isSelected;

  @override
  Widget build(BuildContext context) => Row(
    children: [
      GestureDetector(
        onTap: onTap,
        child: Image.asset(
          isSelected
              ? "assets/images/selected_checkbox.png"
              : "assets/images/question/unchecked_checkbox.png",
          width: 24.w,
          height: 24.h,
        ),
      ),
      SizedBox(width: 8.w),
      RegularText(
        textAlign: TextAlign.start,
        textSize: 12.sp,
        maxLines: 2,
        fontWeight: FontWeight.w500,
        textColor: AppColors.borderBlack,
        textOverflow: TextOverflow.ellipsis,
        text: "Do not have invoice",
      ),
    ],
  );
}
