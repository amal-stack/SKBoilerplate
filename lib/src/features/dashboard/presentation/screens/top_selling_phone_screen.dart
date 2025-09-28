import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:boilerplate/src/shared/widgets/custom_text_feild.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class TopSellingPhoneScreen extends StatefulWidget {
  const TopSellingPhoneScreen({super.key});

  @override
  State<TopSellingPhoneScreen> createState() => _TopSellingPhoneScreenState();
}

class _TopSellingPhoneScreenState extends State<TopSellingPhoneScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.white,
    appBar: AppBar(
      elevation: 0,
      backgroundColor: Colors.white,
      scrolledUnderElevation: 0.0,
      leading:Column(
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

      title:RegularText(
        textAlign: TextAlign.start,
        textSize: 20.sp,
        maxLines: 1,
        fontWeight: FontWeight.w700,
        textColor: AppColors.black,
        textOverflow: TextOverflow.ellipsis,
        text: "Best Deals",
      ),
      bottom: PreferredSize(
        preferredSize:  Size.fromHeight(1),
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
              SizedBox(height: 22.h),
              GridView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                itemCount: 8,
                padding: EdgeInsets.zero,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 images in one row
                  crossAxisSpacing: 10.w, // horizontal space
                  childAspectRatio: 0.65,
                  mainAxisSpacing: 05.h, // vertical space
                ),
                itemBuilder:
                    (context, index) => GestureDetector(
                  onTap: () {
                    context.push('/phone-details');
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x0D2D2E39),
                          offset: Offset(2, 4),
                          blurRadius: 10,
                          spreadRadius: 2,
                        ),
                      ],
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 12.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Center(
                              child: Image.asset(
                                AppAssets.iphoneDisplay,
                                height: 100.h,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.h,
                            ),
                            child: RegularText(
                              text: "iPhone 16 Pro",
                              textAlign: TextAlign.start,
                              textSize: 12.sp,
                              fontWeight: FontWeight.w700,
                              textColor: AppColors.black,
                              maxLines: 2,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),

                          SizedBox(height: 4.h),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.h,
                            ),
                            child: RegularText(
                              text: "126 GB / 256 GB",
                              textAlign: TextAlign.start,
                              textSize: 10.sp,
                              fontWeight: FontWeight.w600,
                              textColor: AppColors.greyColor,
                              maxLines: 1,
                              textOverflow: TextOverflow.ellipsis,
                            ),
                          ),

                          SizedBox(height: 4.h),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.h,
                            ),
                            child: RegularText(
                              text: "Get Upto",
                              textAlign: TextAlign.start,
                              textSize: 8.sp,
                              fontWeight: FontWeight.w700,
                              textColor: AppColors.black,
                            ),
                          ),
                          SizedBox(height: 8.h),
                          Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12.h,
                                ),
                                child: RegularText(
                                  text: "₹ 48,000",
                                  textAlign: TextAlign.start,
                                  textSize: 12.sp,
                                  fontWeight: FontWeight.w700,
                                  textColor: AppColors.darkGreenColor,
                                ),
                              ),
                              Container(
                                width: 66.w,
                                height: 20.h,
                                decoration: BoxDecoration(
                                  color: AppColors.darkGreenColor,
                                  border: Border.all(
                                    width: 1.w,
                                    color: AppColors.borderBlack
                                        .withOpacity(0.1),
                                  ),
                                ),
                                child: Center(
                                  child: RegularText(
                                    text: "Best price",
                                    textAlign: TextAlign.start,
                                    textSize: 10.sp,
                                    fontWeight: FontWeight.w600,
                                    textColor: AppColors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 22.h),
            ],
          ),
        ),
      ),
    ),
  );
}
