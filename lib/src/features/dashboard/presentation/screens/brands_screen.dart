import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:boilerplate/src/shared/widgets/custom_text_feild.dart';


class BrandsScreen extends StatefulWidget {
  const BrandsScreen({super.key});

  @override
  State<BrandsScreen> createState() => _BrandsScreenState();
}

class _BrandsScreenState extends State<BrandsScreen> {
  List<String> brandNameList = [
    "Apple",
    "Huawei",
    "Samsung",
    "Oneplus",
    "Realme",
    "Oppo",
    "Vivo",
    "MI",
    "Pixel",
    "IQOO",
    "Infinix",
    "Motorola",
  ];

  List<String> brandImageList = [
    "assets/images/brands/iphone_brand.png",
    "assets/images/brands/huawel.png",
    "assets/images/brands/samsung_brand.png",
    "assets/images/brands/oneplus.png",
    "assets/images/brands/realme.png",
    "assets/images/brands/oppo.png",
    "assets/images/brands/vivo.png",
    "assets/images/brands/mi.png",
    "assets/images/brands/google_pixel.png",
    "assets/images/brands/iqoo.png",
    "assets/images/brands/infinix.png",
    "assets/images/brands/motorola.png",
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.white,
     appBar:  AppBar(
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
                )
            ),
          ],
        ),

        actions: [
          Row(
            children: [
              Image.asset(
                AppAssets.location,
                width: 24.w,
                height: 24.h,
              ),
              SizedBox(width: 5.w),
              Image.asset(
                AppAssets.notification,
                width: 24.w,
                height: 24.h,
              ),
              SizedBox(width: 5.w),
              Image.asset(
                AppAssets.menu,
                width: 24.w,
                height: 24.h,
              ),
              SizedBox(width: 16.w),
            ],
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Container(
            color: AppColors.dividerColor,
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
            SizedBox(height: 30.h),
            RegularText(
              textAlign: TextAlign.start,
              textSize: 20.sp,
              maxLines: 1,
              fontWeight: FontWeight.w700,
              textColor: AppColors.black,
              textOverflow: TextOverflow.ellipsis,
              text: AppTexts.topSellingBrands,
            ),
            SizedBox(
              height: 8.h,
            ),
            RegularText(
              textAlign: TextAlign.center,
              textSize: 12.sp,
              maxLines: 1,
              fontWeight: FontWeight.w500,
              textColor: AppColors.borderBlack,
              textOverflow: TextOverflow.ellipsis,
              text: AppTexts.topSellingBrandsSubTitle,
            ),
            SizedBox(height: 24.h),
            InputTextField(
              label: "Search for Brand",
              hintMessage: "Search for Brand",
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
            SizedBox(height: 22.h),
            SingleChildScrollView(
              child: Column(
                children: [
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: brandNameList.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // 3 per row
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemBuilder:
                        (context, index) => GestureDetector(
                          onTap: () {
                            context.push('/explore-brands');
                          },
                          child: Container(
                            padding: EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: AppColors.borderBlack.withOpacity(0.10),
                              ),
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SizedBox(height: 10.h),
                                Image.asset(
                                  brandImageList[index].toString(),
                                  height: 34.h,
                                  width: 61.w,
                                ),
                                RegularText(
                                  textAlign: TextAlign.center,
                                  textSize: 12.sp,
                                  maxLines: 1,
                                  fontWeight: FontWeight.w500,
                                  textColor: AppColors.black,
                                  textOverflow: TextOverflow.ellipsis,
                                  text: brandNameList[index],
                                ),
                              ],
                            ),
                          ),
                        ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
