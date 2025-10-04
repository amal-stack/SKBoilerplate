import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

class InputTextField extends StatefulWidget {
  const InputTextField({
    super.key,
    required this.label,
    this.validator,
    this.suffixIcon,
    this.suffix,
    this.prefix,
    this.prefixIcon,
    this.onChanged,
    this.onTap,
    this.onSubmitted,
    this.controller,
    this.mixLines,
    this.hintMessage,


    this.enabledTextField,
    this.labelSize = 12,
    this.inputFormatters,

    this.errorText,
    this.maxLength,
    this.minLength,
    this.counterText,
    this.contentPadding,
    this.isSecure = false,
    this.compareNum = 0.0,
    this.inputNumber = false,
    this.textInputType = TextInputType.text,
    this.textInputAction = TextInputAction.done,
    this.regexExpression,
    this.showTick = false,
    this.isIncome = false,
    this.isDocNumber = false,
    this.showErrorFeild = false,
    this.isAddress = false,
    this.isName = false,
    this.readOnly = false,
    this.isCompany = false,
    this.activeBorder = true,
    this.isBottomPaddingRemove,
  });

  final String label;

  // final String? Function(String?)? validator, onChanged, onSubmitted;
  final String? Function(String?)? validator, onSubmitted;
  final void Function(String)? onChanged;

  final VoidCallback? onTap;
  final Widget? suffixIcon;
  final Widget? suffix;
  final Widget? prefixIcon;
  final Widget? prefix;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final TextEditingController? controller;

  final List<TextInputFormatter>? inputFormatters;
  final String? hintMessage;
  final bool? enabledTextField;

  final double labelSize;
  final int? maxLength;
  final int? minLength;
  final int? mixLines;
  final String? regexExpression;
  final String? errorText;
  final String? counterText;
  final bool? isBottomPaddingRemove;
  final bool? inputNumber;
  final bool? showTick;
  final double? compareNum;
  final bool? isIncome;
  final bool? isDocNumber;
  final bool? isAddress;
  final bool? isName;
  final bool? isCompany;
  final bool? readOnly;
  final bool? isSecure;
  final bool? showErrorFeild;
  final EdgeInsetsGeometry? contentPadding;
  final bool activeBorder;

  //  final EdgeInsetsGeometry? contentPadding;

  @override
  State<InputTextField> createState() => _InputTextFieldState();
}

class _InputTextFieldState extends State<InputTextField> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8.w),
      child: TextFormField(

        inputFormatters: widget.inputFormatters,
        onChanged: widget.onChanged,
        controller: widget.controller,
        enabled: widget.enabledTextField ?? true,

        onTap: widget.onTap ?? () {},
        obscuringCharacter: '●',
        onFieldSubmitted: widget.onSubmitted,
        readOnly: widget.readOnly ?? false,
        obscureText: widget.isSecure ?? false,

        maxLines: widget.mixLines ?? 1,
        textInputAction: widget.textInputAction ?? TextInputAction.done,
        keyboardType: widget.textInputType ?? TextInputType.text,

        //textCapitalization: TextCapitalization.words,
        style: GoogleFonts.montserrat(
          fontWeight: FontWeight.w400,
          fontSize: 14.sp,
          // fontFamily: "ProximaNovaExcn",
        ),
        cursorColor: AppColors.headerTextColor,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        decoration: InputDecoration(
          fillColor: Colors.transparent,
          contentPadding: widget.contentPadding,
          prefixIcon: widget.prefixIcon,
          errorStyle: GoogleFonts.montserrat(
            color: AppColors.errorColor,
            fontSize: 12.sp,
            // fontFamily: "ProximaNovaExcn",
            fontWeight: FontWeight.w500,
          ),
          isDense: false,
          errorText: widget.errorText,
          disabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.greyBorderColor),
            borderRadius: BorderRadius.circular(8.r),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.greyBorderColor),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedBorder:
          widget.activeBorder
              ? OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.baseColor),
            borderRadius: BorderRadius.circular(8.r),
          )
              : OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.greyBorderColor),
            borderRadius: BorderRadius.circular(8.r),
          ),
          border: OutlineInputBorder(
            borderSide: const BorderSide(
              // color: Colors.transparent
              color: AppColors.lightPenColor,
            ),
            borderRadius: BorderRadius.circular(8.r),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.errorColor),
            borderRadius: BorderRadius.circular(8.r),
          ),
          hintText: widget.hintMessage,
          hintStyle: TextStyle(
            color: AppColors.lightGreyColor,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            //height: height,
            fontFamily: "Modelica",
          ),
          // hintStyle: GoogleFonts.montserrat(
          //   fontSize: 15.sp,
          //   fontWeight: FontWeight.w400,
          //   color: AppColors.lightGreyColor,
          // ),
          counterText: widget.counterText ?? "",
          suffix: widget.suffix,
          suffixIcon: widget.suffixIcon,
          filled: true,
        ),
        // keyboardType: !(widget.inputNumber ?? false)
        //     ? TextInputType.text
        //     : TextInputType.number,
        maxLength: widget.maxLength,
        onSaved: (String? value) {},
        validator: widget.validator,
      ),
    );
  }
}
