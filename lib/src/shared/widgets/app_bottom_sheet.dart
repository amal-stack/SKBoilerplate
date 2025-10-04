import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppBottomSheet extends StatelessWidget {
  final bool Function() shouldClose;
  final Widget child;
  final String? bottomSheetTitle;

  const AppBottomSheet({
    super.key,

    required this.shouldClose,
    required this.child,
    this.bottomSheetTitle,
  });

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8.r),
          topRight: Radius.circular(8.r),
        ),
      ),
      onClosing: shouldClose,
      builder: (ctx) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.r),
            color: AppColors.white,
          ),
          padding: EdgeInsets.all(12.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 12.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RegularText(
                    text: bottomSheetTitle ?? '',
                    fontWeight: FontWeight.w600,
                    textSize: 20.sp,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CircleAvatar(
                      backgroundColor: Colors.grey.shade400,
                      radius: 16.r,
                      child: Icon(
                        Icons.close_outlined,
                        size: 16.r,
                        weight: 5.sp,
                        color: AppColors.headerTextColor,
                      ),
                    ),
                  ),
                ],
              ),
              child,
              SizedBox(height: 10.h),
            ],
          ),
        );
      },
    );
  }
}
