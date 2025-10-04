import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/widgets/issue_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/animated_button.dart';

class DefectsSelectionScreen extends StatefulWidget {
  const DefectsSelectionScreen({super.key});

  @override
  State<DefectsSelectionScreen> createState() => _DefectsSelectionScreenState();
}

class _DefectsSelectionScreenState extends State<DefectsSelectionScreen> {
  // Track selected index for each section
  int selectedDeadPixelsIndex = -1;
  int selectedVisibleLinesIndex = -1;
  int selectedDiscolorationIndex = -1;


  final List<Map<String, String>> deadPixelIssues = [
    {"title": "Large or Heavy Visible Spots", "image": "assets/images/question/dead_1.png"},
    {"title": "Three or More Small Spots", "image": "assets/images/question/dead_2.png"},
    {"title": "One or Two Small Spots", "image": "assets/images/question/dead_3.png"},
    {"title": "No Spots onScreen", "image": "assets/images/question/dead_4.png"},
  ];


  final List<Map<String, String>> visibleLineIssues = [
    {"title": "Visible Lines on Screen", "image": "assets/images/question/visible_line_1.png"},
    {"title": "Faded Display Edges", "image": "assets/images/question/visible_line_2.png"},
    {"title": "No Lines on Screen", "image": "assets/images/question/visible_line_3.png"},
  ];

  final List<Map<String, String>> discolorationIssues = [
    {"title": "Severe Discoloration", "image": "assets/images/question/discolor_1.png"},
    {"title": "Minor Discoloration", "image": "assets/images/question/discolor_2.png"},
    {"title": "No Discoloration", "image": "assets/images/question/discolor_3.png"},
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
                      // Section: Dead Pixels / Spots
                      RegularText(
                        text: "Display defects(Spots /Lines)",
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
                        text: "Dead Pixels or Spots",
                        textSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.black,
                      ),
                      SizedBox(height: 24.h),
                      buildIssueRow(deadPixelIssues, selectedDeadPixelsIndex, (index) {
                        setState(() {
                          selectedDeadPixelsIndex = index;
                        });
                      }),
                      SizedBox(height: 24.h),
                      // Section: Visible Lines
                      RegularText(
                        text: "Visible Lines",
                        textSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.black,
                      ),
                      SizedBox(height: 24.h),
                      buildIssueRow(visibleLineIssues, selectedVisibleLinesIndex, (index) {
                        setState(() {
                          selectedVisibleLinesIndex = index;
                        });
                      }),
                      SizedBox(height: 24.h),
                      // Section: Screen Discoloration
                      RegularText(
                        text: "Screen Discoloration",
                        textSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.black,
                      ),
                      SizedBox(height: 24.h),
                      buildIssueRow(discolorationIssues, selectedDiscolorationIndex, (index) {
                        setState(() {
                          selectedDiscolorationIndex = index;
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
                        context.push('/dents-selection-screen');
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
