import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/widgets/issue_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/animated_button.dart';

class WarrantySelectionScreen extends StatefulWidget {
  const WarrantySelectionScreen({super.key});

  @override
  State<WarrantySelectionScreen> createState() =>
      _WarrantySelectionScreenState();
}

class _WarrantySelectionScreenState extends State<WarrantySelectionScreen> {
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
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
                        textSize: 14.sp,
                        maxLines: 2,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.black,
                        textOverflow: TextOverflow.ellipsis,
                        text: "Is your device under warranty?",
                      ),
                      SizedBox(height: 20.h),
                      warrantySelectionWidget(title: "Below 3 months"),
                      SizedBox(height: 10.h),
                      warrantySelectionWidget(title: "Between 3 - 6 months"),
                      SizedBox(height: 10.h),
                      warrantySelectionWidget(title: "Between 6 - 11 months"),
                      SizedBox(height: 10.h),
                      warrantySelectionWidget(title: "Above 11 months"),
                      SizedBox(height: 24.h),
                      RegularText(
                        textAlign: TextAlign.start,
                        textSize: 14.sp,
                        maxLines: 2,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.black,
                        textOverflow: TextOverflow.ellipsis,
                        text: "Upload Invoice",
                      ),
                      SizedBox(height: 8.h),
                      IssueWidget(
                        title: "Invoice",
                        image: "assets/images/question/scratch_1.png",
                      ),
                      SizedBox(height: 50.h),
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
                        context.push('/upload-device-image-screen');
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

  Widget warrantySelectionWidget({required String title}) {
    return Container(
      height: 45.h,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        // card background
        borderRadius: BorderRadius.circular(8),
        // optional corner radius
        boxShadow: [
          BoxShadow(
            color: Color(0x0D2D2E39), // #2D2E390D in Flutter ARGB
            offset: Offset(2, 4), // horizontal & vertical offset
            blurRadius: 10, // blur radius
            spreadRadius: 2, // spread radius
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Center(
          child: RegularText(
            textAlign: TextAlign.end,
            textSize: 12.sp,
            maxLines: 1,
            fontWeight: FontWeight.w700,
            textColor: AppColors.black,
            textOverflow: TextOverflow.ellipsis,
            text: title,
          ),
        ),
      ),
    );
  }
}
