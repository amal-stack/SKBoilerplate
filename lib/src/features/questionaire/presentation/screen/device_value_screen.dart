import 'package:boilerplate/src/features/questionaire/domain/entities/device_grade.dart';
import 'package:boilerplate/src/shared/themes/text.dart' as custom;
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/widgets/faq_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class DeviceValueScreen extends StatefulWidget {
  const DeviceValueScreen({super.key, required this.result});

  final DeviceAssessmentResult result;

  @override
  State<DeviceValueScreen> createState() => _DeviceValueScreenState();
}

class _DeviceValueScreenState extends State<DeviceValueScreen> {
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

  Future<void> showTermsDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: true, // close when tapping outside
      builder: (context) {
        return Dialog(
          backgroundColor: AppColors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    RegularText(
                      textAlign: TextAlign.right,
                      textSize: 16.sp,
                      maxLines: 3,
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.black,
                      textOverflow: TextOverflow.ellipsis,
                      text: "Terms & Conditions",
                    ),

                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Icon(Icons.close, size: 20.sp),
                    ),
                  ],
                ),
                SizedBox(height: 12.h),
                Flexible(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: List.generate(5, (index) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 8.h),
                          child: RegularText(
                            textAlign: TextAlign.left,
                            textSize: 13.sp,
                            maxLines: 3,
                            fontWeight: FontWeight.w400,
                            textColor: AppColors.borderBlack,
                            textOverflow: TextOverflow.ellipsis,
                            text:
                                "${index + 1}. How does this mobile exchange process work. How does this mobile exchange process work.",
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

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
          text: "Device value",
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(
                      "assets/images/phone_ad.png",
                      width: 110.w,
                      height: 138.h,
                    ),
                    SizedBox(width: 14.w),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        RegularText(
                          textAlign: TextAlign.start,
                          textSize: 16.sp,
                          maxLines: 1,
                          fontWeight: FontWeight.w700,
                          textColor: AppColors.black,
                          textOverflow: TextOverflow.ellipsis,
                          text: "Apple iPhone 16 plus",
                        ),
                        SizedBox(height: 16.w),
                        Row(
                          children: [
                            custom.RichText(
                              texts: [
                                TextModel(
                                  "Variant : ",
                                  size: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.borderBlack,
                                ),
                                TextModel(
                                  " 64GB  |",
                                  size: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.borderBlack,
                                ),
                              ],
                              maxLines: 3,
                            ),
                            custom.RichText(
                              texts: [
                                TextModel(
                                  " Grade : ",
                                  size: 12.sp,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.borderBlack,
                                ),
                                TextModel(
                                  widget.result.grade.value,
                                  size: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.darkGreenColor,
                                ),
                              ],
                              maxLines: 3,
                            ),
                          ],
                        ),
                        SizedBox(height: 16.w),
                        Column(
                          children: [
                            RegularText(
                              textAlign: TextAlign.start,
                              textSize: 12.sp,
                              maxLines: 1,
                              fontWeight: FontWeight.w600,
                              textColor: AppColors.black,
                              textOverflow: TextOverflow.ellipsis,
                              text: "Final selling price",
                            ),
                            SizedBox(height: 8.w),
                            RegularText(
                              textAlign: TextAlign.start,
                              textSize: 24.sp,
                              maxLines: 1,
                              fontWeight: FontWeight.w700,
                              textColor: AppColors.darkGreenColor,
                              textOverflow: TextOverflow.ellipsis,
                              text: "₹ ${widget.result.price}"
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(height: 16.h),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: 155.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1.w,
                          color: AppColors.greyBorderColor,
                        ),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child:Center(
                        child: RegularText(
                          textAlign: TextAlign.start,
                          textSize: 14.sp,
                          maxLines: 1,
                          fontWeight: FontWeight.w700,
                          textColor: AppColors.borderBlack,
                          textOverflow: TextOverflow.ellipsis,
                          text: "Calculate again",
                        ),
                      )
                    ),
                    GestureDetector(
                      onTap: (){
                        context.push('/phone-number-verification-screen');
                      },
                      child:  Container(
                          width: 155.w,
                          height: 48.h,
                          decoration: BoxDecoration(
                            color: AppColors.baseColor,
                            border: Border.all(
                              width: 1.w,
                              color: AppColors.baseColor,
                            ),
                            borderRadius: BorderRadius.circular(8.r),
                          ),
                          child:Center(
                            child: RegularText(
                              textAlign: TextAlign.start,
                              textSize: 14.sp,
                              maxLines: 1,
                              fontWeight: FontWeight.w700,
                              textColor: AppColors.white,
                              textOverflow: TextOverflow.ellipsis,
                              text: "Continue to Sell",
                            ),
                          )
                      )
                    ),
                  ],
                ),
                SizedBox(height: 24.h),
                RegularText(
                  textAlign: TextAlign.start,
                  textSize: 14.sp,
                  maxLines: 1,
                  fontWeight: FontWeight.w700,
                  textColor: AppColors.black,
                  textOverflow: TextOverflow.ellipsis,
                  text: "Frequently asked question",
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

                SizedBox(height: 24.h),
                Align(
                  alignment: Alignment.center,
                  child: RegularText(
                    textAlign: TextAlign.end,
                    textSize: 14.sp,
                    maxLines: 2,
                    fontWeight: FontWeight.w700,
                    textColor: AppColors.loadMoreColor,
                    textOverflow: TextOverflow.ellipsis,
                    text: AppTexts.loadMore,
                  ),
                ),
                SizedBox(height: 30.h),
                RegularText(
                  textAlign: TextAlign.end,
                  textSize: 14.sp,
                  maxLines: 2,
                  fontWeight: FontWeight.w700,
                  textColor: AppColors.black,
                  textOverflow: TextOverflow.ellipsis,
                  text: AppTexts.termsAndConditions,
                ),
                SizedBox(height: 20.h),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.white, // background color
                    borderRadius: BorderRadius.circular(12.w),
                    border: Border.all(
                      color: AppColors.black.withOpacity(0.1),
                      width: 1.w,
                    ), // rounded corners
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RegularText(
                        textAlign: TextAlign.start,
                        textSize: 13.sp,
                        maxLines: 3,
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.borderBlack,
                        textOverflow: TextOverflow.ellipsis,
                        text: AppTexts.termsOne,
                      ),
                      SizedBox(height: 8.h),
                      RegularText(
                        textAlign: TextAlign.start,
                        textSize: 13.sp,
                        maxLines: 3,
                        fontWeight: FontWeight.w400,
                        textColor: AppColors.borderBlack,
                        textOverflow: TextOverflow.ellipsis,
                        text: AppTexts.termsTwo,
                      ),
                      SizedBox(height: 8.h),
                      GestureDetector(
                        onTap: () {
                          showTermsDialog(context);
                        },
                        child: Align(
                          alignment: Alignment.topRight,
                          child: RegularText(
                            textAlign: TextAlign.right,
                            textSize: 12.sp,
                            maxLines: 3,
                            fontWeight: FontWeight.w700,
                            textColor: AppColors.darkSkyBlueColor,
                            textOverflow: TextOverflow.ellipsis,
                            text: AppTexts.readMore,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
