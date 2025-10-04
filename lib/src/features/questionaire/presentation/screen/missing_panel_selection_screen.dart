import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/widgets/issue_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/animated_button.dart';

class MissingPanelSelectionScreen extends StatefulWidget {
  const MissingPanelSelectionScreen({super.key});

  @override
  State<MissingPanelSelectionScreen> createState() =>
      _MissingPanelSelectionScreenState();
}

class _MissingPanelSelectionScreenState extends State<MissingPanelSelectionScreen> {
  // Track selected index for each section
  int selectedPanelIndex = -1;
  int selectedBentIndex = -1;

  final List<Map<String, String>> panelIssues = [
    {"title": "Cracked or Broken Side/Back Panel", "image": "assets/images/question/scratch_1.png"},
    {"title": "Side or Back Panel Missing", "image": "assets/images/question/lines_1.png"},
    {"title": "No Damage on Side/Back Panel", "image": "assets/images/question/scratch_1.png"},
  ];

  final List<Map<String, String>> bentIssues = [
    {"title": "Bent or Curved Frame", "image": "assets/images/question/scratch_1.png"},
    {"title": "Loose Between Screen & Body", "image": "assets/images/question/lines_1.png"},
    {"title": "Frame is Straight (Not Bent)", "image": "assets/images/question/scratch_1.png"},
  ];

  Widget buildIssueRow(List<Map<String, String>> issues, int selectedIndex, Function(int) onSelect) {
    return Wrap(
      spacing: 12.w,
      runSpacing: 8.h,
      children: List.generate(
        issues.length,
            (index) {
          return SizedBox(
            width: 155.w,
            child: IssueWidget(
              title: issues[index]["title"]!,
              image: issues[index]["image"]!,
              isSelected: selectedIndex == index,
              onTap: () => onSelect(index),
            ),
          );
        },
      ),
    );
  }

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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 30.h),
                      RegularText(
                        text: "Broken/missing panel",
                        textSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.black,
                      ),
                      SizedBox(height: 8.h),
                      RegularText(
                        text: "Select all the issues/defects in the device",
                        textSize: 12.sp,
                        fontWeight: FontWeight.w500,
                        textColor: AppColors.borderBlack,
                      ),
                      SizedBox(height: 16.h),
                      RegularText(
                        text: "Device Side/Back Panel Condition",
                        textSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.black,
                      ),
                      SizedBox(height: 24.h),
                      buildIssueRow(panelIssues, selectedPanelIndex, (index) {
                        setState(() {
                          selectedPanelIndex = index;
                        });
                      }),
                      SizedBox(height: 24.h),
                      RegularText(
                        text: "Device Bent/Screen loose",
                        textSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.black,
                      ),
                      SizedBox(height: 24.h),
                      buildIssueRow(bentIssues, selectedBentIndex, (index) {
                        setState(() {
                          selectedBentIndex = index;
                        });
                      }),
                      SizedBox(height: 50.h),
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
                        context.push('/additional-issues-screen');
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

