import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/widgets/issue_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/animated_button.dart';

class ScratchSelectionScreen extends StatefulWidget {
  const ScratchSelectionScreen({super.key});

  @override
  State<ScratchSelectionScreen> createState() => _ScratchSelectionScreenState();
}

class _ScratchSelectionScreenState extends State<ScratchSelectionScreen> {
  int selectedIndex = -1; // -1 means nothing is selected

  final List<Map<String, String>> issues = [
    {
      "title": "Cracked Screen or Broken Glass",
      "image": "assets/images/question/scratch_1.png",
    },
    {
      "title": "Cracks Outside the Display Area",
      "image": "assets/images/question/scratch_2.png",
    },
    {
      "title": "Multiple Scratches (More than 2)",
      "image": "assets/images/question/scratch_3.png",
    },
    {
      "title": "Minor Scratches (1–2 on Screen)",
      "image": "assets/images/question/scratches_4.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0.0,
        leading: IconButton(
          icon:  GestureDetector(
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
              )
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title:RegularText(
          textAlign: TextAlign.start,
          textSize: 20.sp,
          maxLines: 1,
          fontWeight: FontWeight.w700,
          textColor: AppColors.black,
          textOverflow: TextOverflow.ellipsis,
          text: "Verify product condition",
        ),
        bottom: PreferredSize(
          preferredSize:  Size.fromHeight(1),
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
                        text: "Screen cracks/scratches",
                        textAlign: TextAlign.start,
                        textSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.black,
                      ),
                      SizedBox(height: 8.h),
                      RegularText(
                        text: "Select all the issues/defects in the device",
                        textAlign: TextAlign.start,
                        textSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.borderBlack,
                      ),
                      SizedBox(height: 24.h),
                      // Render issues in rows of 2
                      Wrap(
                        spacing: 12.w,
                        runSpacing: 8.h,
                        children: List.generate(
                          issues.length,
                              (index) {
                            return SizedBox(
                              width: (155.w),
                              child: IssueWidget(
                                image: issues[index]["image"]!,
                                title: issues[index]["title"]!,
                                isSelected: selectedIndex == index,
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index; // single selection
                                  });
                                },
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 45.h,
                    width: double.infinity,
                    child: AnimatedButton(
                      disableButton: false,
                      isLoading: false,
                      onPressed: () {
                        context.push('/defects-selection-screen');
                      },
                      label: AppTexts.continueTitle,
                      fontSize: 12.sp,
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
