import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/widgets/issue_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/animated_button.dart';

class AdditionalIssuesScreen extends StatefulWidget {
  const AdditionalIssuesScreen({super.key});

  @override
  State<AdditionalIssuesScreen> createState() => _AdditionalIssuesScreenState();
}

class _AdditionalIssuesScreenState extends State<AdditionalIssuesScreen> {
  // Track selected index for each section
  int selectedDeviceIssueIndex = -1;
  int selectedBatteryIndex = -1;

  final List<Map<String, String>> deviceIssues = [
    {"title": "Front Camera is not working", "image": "assets/images/question/additional_1.png"},
    {"title": "Rear Camera is not working", "image": "assets/images/question/additional_2.png"},
    {"title": "Volume Buttons are unresponsive", "image": "assets/images/question/scratch_1.png"},
    {"title": "Fingerprint sensor not working", "image": "assets/images/question/additional_4.png"},
    {"title": "Wi-Fi not connecting", "image": "assets/images/question/additional_5.png"},
    {"title": "Speaker malfunctioning", "image": "assets/images/question/scratch_1.png"},
    {"title": "Silent switch not working", "image": "assets/images/question/scratch_1.png"},
    {"title": "Face recognition sensor not working", "image": "assets/images/question/additioal_8.png"},
    {"title": "Power button unresponsive", "image": "assets/images/question/scratch_1.png"},
    {"title": "Charging port not working", "image": "assets/images/question/scratch_1.png"},
    {"title": "Audio receiver faulty", "image": "assets/images/question/additional_11.png"},
    {"title": "Camera glass broken", "image": "assets/images/question/additional_12.png"},
    {"title": "Microphone not working", "image": "assets/images/question/additioal_13.png"},
    {"title": "Bluetooth not connecting", "image": "assets/images/question/additional_14.png"},
    {"title": "Vibration motor not working", "image": "assets/images/question/additional_15.png"},
    {"title": "Proximity sensor not functioning", "image": "assets/images/question/additional_16.png"},
  ];

  final List<Map<String, String>> batteryIssues = [
    {"title": "Battery requires service (health below 80%)", "image": "assets/images/question/battery_1.png"},
    {"title": "Battery health at 80–85%", "image": "assets/images/question/battery_2.png"},
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
        leading:
            GestureDetector(
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
                        text: "Additional Device Issues",
                        textSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.black,
                      ),
                      SizedBox(height: 24.h),
                      buildIssueRow(deviceIssues, selectedDeviceIssueIndex, (index) {
                        setState(() {
                          selectedDeviceIssueIndex = index;
                        });
                      }),
                      SizedBox(height: 24.h),
                      RegularText(
                        text: "Battery Health",
                        textSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        textColor: AppColors.black,
                      ),
                      SizedBox(height: 24.h),
                      buildIssueRow(batteryIssues, selectedBatteryIndex, (index) {
                        setState(() {
                          selectedBatteryIndex = index;
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
                        context.push('/available-accessories-screen');
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
