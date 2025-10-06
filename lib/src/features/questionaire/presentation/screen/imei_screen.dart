import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_assets.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/widgets/custom_text_field.dart';
import 'package:boilerplate/src/shared/widgets/faq_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../shared/widgets/animated_button.dart';

class ImeiScreen extends StatefulWidget {
  const ImeiScreen({super.key});

  @override
  State<ImeiScreen> createState() => _ImeiScreenState();
}

class _ImeiScreenState extends State<ImeiScreen> {
  void toggleExpansion(int index) {
    setState(() {
      if (_expandedIndex == index) {
        _expandedIndex = null; // collapse
      } else {
        _expandedIndex = index; // expand selected
      }
    });
  }

  int? _expandedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          icon: GestureDetector(
            onTap: () {
              context.pop();
            },
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Image.asset(
                "assets/images/left_arrow.png",
                width: 24.w,
                height: 24.h,
                fit: BoxFit.contain,
              ),
            ),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: RegularText(
          textAlign: TextAlign.start,
          textSize: 20.sp,
          maxLines: 1,
          fontWeight: FontWeight.w700,
          textColor: AppColors.black,
          textOverflow: TextOverflow.ellipsis,
          text: "Enter IMEI number",
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            color: AppColors.dividerColor, // grey divider line
            height: 1,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30.h),
                RegularText(
                  textAlign: TextAlign.start,
                  textSize: 12.sp,
                  maxLines: 2,
                  fontWeight: FontWeight.w600,
                  textColor: AppColors.borderBlack,
                  textOverflow: TextOverflow.ellipsis,
                  text:
                      "Please enter the IMEI number to fetch the accurate price",
                ),
                SizedBox(height: 40.h),
                Align(
                  alignment: Alignment.center,
                  child: Image.asset(
                    AppAssets.imei,
                    width: 234.w,
                    height: 120.h,
                  ),
                ),

                SizedBox(height: 24.h),
                InputTextField(
                  label: "Enter IMEI number",
                  hintMessage: "Enter IMEI number",
                  textInputType: TextInputType.number,
                  maxLength: 16,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(16),
                  ],
                ),
                SizedBox(height: 22.h),
                SizedBox(
                  height: 45.h,
                  width: double.infinity,
                  child: AnimatedButton(
                    disableButton: false,
                    isLoading: false,
                    onPressed: () {
                      context.push('/product-question-answer');
                    },
                    label: AppTexts.continueTitle,
                    fontSize: 12.sp,
                    isSmallButton: false,
                  ),
                ),
                SizedBox(height: 30.h),
                RegularText(
                  textAlign: TextAlign.start,
                  textSize: 14.sp,
                  maxLines: 1,
                  fontWeight: FontWeight.w700,
                  textColor: AppColors.black,
                  textOverflow: TextOverflow.ellipsis,
                  text: "Where can I find the IMEI number?",
                ),
                SizedBox(height: 20.h),
                FaqItem(
                  question: "Method 1 : From the phone box",
                  answer: AppTexts.answer,
                  expandedIndex: _expandedIndex,
                  index: 0,
                  onTap: toggleExpansion,
                ),
                SizedBox(height: 8.h),
                FaqItem(
                  question: "Method 1 : From the phone box",
                  answer: AppTexts.answer,
                  expandedIndex: _expandedIndex,
                  index: 1,
                  onTap: toggleExpansion,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
