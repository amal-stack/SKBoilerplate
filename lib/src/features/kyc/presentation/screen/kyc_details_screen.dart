import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/widgets/animated_button.dart';
import 'package:boilerplate/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class KycDetailsScreen extends StatefulWidget {
  const KycDetailsScreen({super.key});

  @override
  State<KycDetailsScreen> createState() => _KycDetailsScreenState();
}

class _KycDetailsScreenState extends State<KycDetailsScreen> {
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
          text: "KYC Verification",
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 24.h),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: RegularText(
                            textAlign: TextAlign.start,
                            textSize: 16.sp,
                            maxLines: 2,
                            fontWeight: FontWeight.w700,
                            textColor: AppColors.borderBlack,
                            textOverflow: TextOverflow.ellipsis,
                            text: "Provide your details",
                          ),
                        ),
                      ),
                      SizedBox(height: 24.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 80.h,
                            width: 150.w,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: RegularText(
                                      textAlign: TextAlign.start,
                                      textSize: 14.sp,
                                      maxLines: 2,
                                      fontWeight: FontWeight.w600,
                                      textColor: AppColors.borderBlack,
                                      textOverflow: TextOverflow.ellipsis,
                                      text: "First Name",
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                InputTextField(
                                  label: "First Name",
                                  hintMessage: "First Name",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 80.h,
                            width: 150.w,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: RegularText(
                                      textAlign: TextAlign.start,
                                      textSize: 14.sp,
                                      maxLines: 2,
                                      fontWeight: FontWeight.w600,
                                      textColor: AppColors.borderBlack,
                                      textOverflow: TextOverflow.ellipsis,
                                      text: "Last Name",
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                InputTextField(
                                  label: "Last Name",
                                  hintMessage: "Last Name",
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: RegularText(
                            textAlign: TextAlign.start,
                            textSize: 14.sp,
                            maxLines: 2,
                            fontWeight: FontWeight.w600,
                            textColor: AppColors.borderBlack,
                            textOverflow: TextOverflow.ellipsis,
                            text: "Address* ",
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      InputTextField(
                        label: "Address* ",
                        hintMessage: "Address",
                      ),
                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: RegularText(
                            textAlign: TextAlign.start,
                            textSize: 14.sp,
                            maxLines: 2,
                            fontWeight: FontWeight.w600,
                            textColor: AppColors.borderBlack,
                            textOverflow: TextOverflow.ellipsis,
                            text: "Address* ",
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      InputTextField(
                        label: "Address* ",
                        hintMessage: "Address",
                      ),
                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: RegularText(
                            textAlign: TextAlign.start,
                            textSize: 14.sp,
                            maxLines: 2,
                            fontWeight: FontWeight.w600,
                            textColor: AppColors.borderBlack,
                            textOverflow: TextOverflow.ellipsis,
                            text: "Address* ",
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      InputTextField(
                        label: "Address* ",
                        hintMessage: "Address",
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            height: 80.h,
                            width: 150.w,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: RegularText(
                                      textAlign: TextAlign.start,
                                      textSize: 14.sp,
                                      maxLines: 2,
                                      fontWeight: FontWeight.w600,
                                      textColor: AppColors.borderBlack,
                                      textOverflow: TextOverflow.ellipsis,
                                      text: "City",
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                InputTextField(
                                  label: "City",
                                  hintMessage: "City",
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 80.h,
                            width: 150.w,
                            child: Column(
                              children: [
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 8.w),
                                    child: RegularText(
                                      textAlign: TextAlign.start,
                                      textSize: 14.sp,
                                      maxLines: 2,
                                      fontWeight: FontWeight.w600,
                                      textColor: AppColors.borderBlack,
                                      textOverflow: TextOverflow.ellipsis,
                                      text: "Pin code",
                                    ),
                                  ),
                                ),
                                SizedBox(height: 8.h),
                                InputTextField(
                                  label: "Pin code",
                                  hintMessage: "Pin code",
                                ),
                              ],
                            ),
                          ),

                        ],
                      ),
                      SizedBox(height: 8.h),
                      Align(
                        alignment: Alignment.topLeft,
                        child: Padding(
                          padding: EdgeInsets.only(left: 8.w),
                          child: RegularText(
                            textAlign: TextAlign.start,
                            textSize: 14.sp,
                            maxLines: 2,
                            fontWeight: FontWeight.w600,
                            textColor: AppColors.borderBlack,
                            textOverflow: TextOverflow.ellipsis,
                            text: "State ",
                          ),
                        ),
                      ),
                      SizedBox(height: 8.h),
                      InputTextField(
                        label: "State",
                        hintMessage: "State",
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
                      onPressed: () => context.push('/upload-document-screen'),
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
