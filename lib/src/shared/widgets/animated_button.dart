import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../utils/app_colors.dart';

class AnimatedButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final String label;
  final FontWeight labelFontWeight;
  final bool disableButton;
  final Color? buttonColor;
  final Color? borderColor;
  final Color? labelColor;
  final bool isSmallButton;
  final double? fontSize;
  final bool isLoading;

  const AnimatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.buttonColor,
    this.borderColor,
    this.labelColor,
    this.isSmallButton = false,
    this.disableButton = false,
    this.labelFontWeight = FontWeight.bold,
    this.fontSize,
    this.isLoading = false,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  @override
  Widget build(BuildContext context) {
    final bool isDisabled = widget.disableButton || widget.isLoading;

    final Color currentButtonColor = isDisabled
        ? Color.alphaBlend(
            AppColors.baseColor.withValues(alpha: 0.3),
            Colors.white,
          )
        : widget.buttonColor ?? AppColors.baseColor;

    return AnimatedContainer(
      width: widget.isSmallButton ? 0.4.sw : 0.9.sw,
      height: widget.isSmallButton ? 40.h : 50.h,
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: currentButtonColor,
        borderRadius: BorderRadius.circular(15.r),
        border: Border.all(color: widget.borderColor ?? Colors.transparent),
      ),
      child: MaterialButton(
        onPressed: isDisabled ? null : widget.onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.r),
        ),
        child: Center(
          child: widget.isLoading
              ? SizedBox(
                  width: 22.w,
                  height: 22.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: widget.fontSize ?? 14.sp,
                    color: widget.labelColor ?? Colors.white,
                    fontWeight: widget.labelFontWeight,
                  ),
                ),
        ),
      ),
    );
  }
}

Widget animatedLoader() {
  return SizedBox(
    height: 1.sh, // ScreenUtil → full height
    width: 1.sw, // ScreenUtil → full width
    child: const Center(child: CircularProgressIndicator(color: Colors.pink)),
  );
}
