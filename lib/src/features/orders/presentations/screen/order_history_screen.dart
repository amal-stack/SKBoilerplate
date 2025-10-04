import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.white,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0.0,
      leading: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
            ),
          ),
        ],
      ),
      title: RegularText(
        textAlign: TextAlign.start,
        textSize: 20.sp,
        maxLines: 1,
        fontWeight: FontWeight.w700,
        textColor: AppColors.black,
        textOverflow: TextOverflow.ellipsis,
        text: "Order history",
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
              //  SizedBox(height: 24.h),
              Row(
                children: [
                  Flexible(
                    child: InputTextField(
                      label: "Search",
                      hintMessage: "Search",
                      prefixIcon: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/search.png",
                            width: 20.w,
                            height: 20.h,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 10.w),
                  Image.asset(
                    "assets/images/filter.png",
                    width: 24.w,
                    height: 24.h,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
              SizedBox(height: 30.h),
              RegularText(
                textAlign: TextAlign.start,
                textSize: 14.sp,
                maxLines: 1,
                fontWeight: FontWeight.w600,
                textColor: AppColors.borderBlack,
                textOverflow: TextOverflow.ellipsis,
                text: "81 orders has been completed successfully",
              ),
              SizedBox(height: 10.h),
              ListView.builder(
                itemCount: 5,
                shrinkWrap: true,
                physics:
                    const ScrollPhysics(), // or NeverScrollableScrollPhysics()
                scrollDirection: Axis.vertical,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: OrderHistoryWidget(),
                  );
                },
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    ),
  );
}

class OrderHistoryWidget extends StatelessWidget {
  const OrderHistoryWidget({super.key});

  @override
  Widget build(BuildContext context) => Container(
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(8.w),
      border: Border.all(
        color: AppColors.borderBlack.withOpacity(0.1),
        width: 1.w,
      ),
    ),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RegularText(
              textAlign: TextAlign.start,
              textSize: 12.sp,
              maxLines: 1,
              fontWeight: FontWeight.w500,
              textColor: AppColors.black,
              textOverflow: TextOverflow.ellipsis,
              text: "#ABH-3485GT | 12:25 pm, 12-12-2024",
            ),
            SizedBox(
              width: 20.w,
              height: 20.h,
              child: Lottie.asset('assets/gifs/Success.json'),
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          children: [
            CircleAvatar(
              radius: 24.r,
              backgroundColor: AppColors.greyBorderColor,
            ),
            SizedBox(width: 16.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RegularText(
                  textAlign: TextAlign.start,
                  textSize: 12.sp,
                  maxLines: 1,
                  fontWeight: FontWeight.w700,
                  textColor: AppColors.black,
                  textOverflow: TextOverflow.ellipsis,
                  text: "Santosh Kumar",
                ),
                SizedBox(height: 3.h),
                RegularText(
                  textAlign: TextAlign.start,
                  textSize: 12.sp,
                  maxLines: 1,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.black,
                  textOverflow: TextOverflow.ellipsis,
                  text: "+91 1234567890",
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 20.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 24.r,
                  backgroundColor: AppColors.greyBorderColor,
                ),
                SizedBox(width: 16.w),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RegularText(
                      textAlign: TextAlign.start,
                      textSize: 12.sp,
                      maxLines: 1,
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.black,
                      textOverflow: TextOverflow.ellipsis,
                      text: "Apple iPhone 16 Plus",
                    ),
                    SizedBox(height: 8.h),
                    RegularText(
                      textAlign: TextAlign.start,
                      textSize: 12.sp,
                      maxLines: 1,
                      fontWeight: FontWeight.w500,
                      textColor: AppColors.black,
                      textOverflow: TextOverflow.ellipsis,
                      text: "Variant :  64GB",
                    ),
                  ],
                ),
              ],
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                RegularText(
                  textAlign: TextAlign.start,
                  textSize: 10.sp,
                  maxLines: 1,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.black,
                  textOverflow: TextOverflow.ellipsis,
                  text: "Purchase price",
                ),
                SizedBox(height: 8.h),
                RegularText(
                  textAlign: TextAlign.start,
                  textSize: 14.sp,
                  maxLines: 1,
                  fontWeight: FontWeight.w700,
                  textColor: AppColors.darkGreenColor,
                  textOverflow: TextOverflow.ellipsis,
                  text: "48000/-",
                ),
              ],
            ),
          ],
        ),
        SizedBox(height: 8.h),
        GestureDetector(
          onTap: () {
            context.push('/completed-order-details-screen');
          },
          child: Align(
            alignment: Alignment.topRight,
            child: RegularText(
              textAlign: TextAlign.end,
              textSize: 12.sp,
              maxLines: 1,
              fontWeight: FontWeight.w700,
              textColor: AppColors.baseColor,
              textOverflow: TextOverflow.ellipsis,
              text: "View Details  |  Download Invoice",
            ),
          ),
        ),
      ],
    ),
  );
}
