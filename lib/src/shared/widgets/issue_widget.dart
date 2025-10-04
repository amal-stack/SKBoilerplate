import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';

class IssueWidget extends StatefulWidget {
  const IssueWidget({
    super.key,
    required this.image,
    required this.title,
    this.isSelected, // external control (optional)
    this.onTap,
  });

  final String image;
  final String title;
  final bool? isSelected; // parent can control selection
  final VoidCallback? onTap;

  @override
  State<IssueWidget> createState() => _IssueWidgetState();
}

class _IssueWidgetState extends State<IssueWidget> {
  bool _internalSelected = false; // internal state fallback

  void _handleTap() {
    // If parent is not controlling, toggle internal state
    if (widget.isSelected == null) {
      setState(() {
        _internalSelected = !_internalSelected;
      });
    }

    // Call parent's onTap if provided
    if (widget.onTap != null) widget.onTap!();
  }

  @override
  Widget build(BuildContext context) {
    final bool selected = widget.isSelected ?? _internalSelected;

    return GestureDetector(
      onTap: _handleTap,
      child: Container(
        width: 155.w,
        height: 207.h,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: const Color(0x0D2D2E39),
              offset: const Offset(2, 4),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
          border: Border.all(
            width: 1.w,
            color: selected ? AppColors.introSliderCircleColor : Colors.transparent,
          ),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child:Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  widget.image,
                  width: 46.w,
                  height: 104.h,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 16.h),
                SizedBox(
                  width: 134.w,
                  child: RegularText(
                    textAlign: TextAlign.center,
                    textSize: 12.sp,
                    maxLines: 4,
                    fontWeight: FontWeight.w500,
                    textColor: AppColors.borderColor,
                    textOverflow: TextOverflow.ellipsis,
                    text: widget.title,
                  ),
                ),
              ],
            ),
            selected ?  Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  height: 6.h,
                  width: 155.w,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(bottomRight: Radius.circular(8.r),bottomLeft: Radius.circular(8.r)),
                      color:  AppColors.introSliderCircleColor
                  ),

              ),
            ) : Container()

          ],
        )

      ),
    );
  }
}
