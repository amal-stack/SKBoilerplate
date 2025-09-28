import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/widgets/issue_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/animated_button.dart';

class ProductConditionScreen extends StatefulWidget {
  const ProductConditionScreen({super.key});

  @override
  State<ProductConditionScreen> createState() => _ProductConditionScreenState();
}

class _ProductConditionScreenState extends State<ProductConditionScreen> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
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
          text: "Verify product condition",
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            color: AppColors.dividerColor, // grey divider line
            height: 1,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      RegularText(
                        textAlign: TextAlign.start,
                        textSize: 16.sp,
                        maxLines: 2,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.black,
                        textOverflow: TextOverflow.ellipsis,
                        text: "Select device issues",
                      ),
                      SizedBox(height: 8.h),
                      RegularText(
                        textAlign: TextAlign.start,
                        textSize: 12.sp,
                        maxLines: 2,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.borderBlack,
                        textOverflow: TextOverflow.ellipsis,
                        text: "Select all the issues/defects in the device",
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IssueWidget(
                            title: "Cracks/scratch on device screen",
                            image: "assets/images/question/scratch_1.png",
                          ),
                          IssueWidget(
                            title: "Display defects (spots/lines)",
                            image: "assets/images/question/lines_1.png",
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IssueWidget(
                            title: "Scratch/Dent on device body",
                            image: "assets/images/question/dent_1.png",
                          ),
                          IssueWidget(
                            title: "Device panel missing/broken",
                            image: "assets/images/question/panel_1.png",
                          ),
                        ],
                      ),
                      SizedBox(height: 8.h),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            isSelected = !isSelected;
                          });
                        },
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
                        text: "Device do not have any defects",
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),
                  SizedBox(
                    height: 45.h,
                    width: double.infinity,
                    child: AnimatedButton(
                      disableButton: false,
                      isLoading: false,
                      onPressed: () {
                        context.push('/scratch-selection-screen');
                      },
                      label: AppTexts.continueTitle,
                      fontSize: 12.sp,
                      isSmallButton: false,
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
