import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_assets.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/widgets/custom_text_field.dart';
import 'package:boilerplate/src/shared/widgets/qa_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widget_previews.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

Widget screenUtilWrapper(Widget child) => ScreenUtilInit(
  designSize: const Size(375, 812),
  minTextAdapt: true,
  splitScreenMode: true,
  builder: (_, _) => MaterialApp(
    debugShowCheckedModeBanner: false,
    home: child,
  ),
);


class DashboardScreen extends StatefulWidget {
  @Preview(wrapper: screenUtilWrapper)
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List<String> imageList = [
    "assets/images/iphone.png",
    "assets/images/huawei.png",
    "assets/images/samsung.png",
  ];

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

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: AppColors.white,
    body: SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    AppAssets.appLogoBlack,
                    width: 98.w,
                    height: 24.h,
                    fit: BoxFit.contain,
                  ),
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
                        "assets/images/menu.png",
                        width: 24.w,
                        height: 24.h,
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              InputTextField(
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
              SizedBox(height: 24.h),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // context.push('/top-selling-phones');
                  GestureDetector(
                    onTap: () {
                    //  context.push('/order-history-screen');
                    },
                    child: Container(
                      width: 100.w,
                      height: 84.h,
                      decoration: BoxDecoration(
                        color: AppColors.lightBorderColor.withValues(
                          alpha: 0.13,
                        ),
                        border: Border.all(
                          width: 1.w,
                          color: AppColors.lightBorderColor.withValues(
                            alpha: 0.13,
                          ),
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            RegularText(
                              textAlign: TextAlign.center,
                              textSize: 24.sp,
                              maxLines: 2,
                              fontWeight: FontWeight.bold,
                              textColor: AppColors.lightGreenColor,
                              textOverflow: TextOverflow.ellipsis,
                              text: "24",
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                SizedBox(
                                  width: 58.h,
                                  child: RegularText(
                                    textAlign: TextAlign.start,
                                    textSize: 9.sp,
                                    maxLines: 2,
                                    fontWeight: FontWeight.w700,
                                    textColor: AppColors.orderTitleColor,
                                    textOverflow: TextOverflow.ellipsis,
                                    text: AppTexts.onGoingOrders,
                                  ),
                                ),
                                Center(
                                  child: Image.asset(
                                    "assets/images/right_arrow_black.png",
                                    width: 18.w,
                                    height: 18.h,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  SizedBox(width: 8.w),
                  Container(
                    width: 100.w,
                    height: 84.h,
                    decoration: BoxDecoration(
                      color: AppColors.skyBlueColor.withOpacity(0.27),
                      border: Border.all(
                        width: 1.w,
                        color: AppColors.skyBlueColor.withOpacity(0.10),
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RegularText(
                            textAlign: TextAlign.center,
                            textSize: 24.sp,
                            maxLines: 2,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.darkSkyBlueTitleColor,
                            textOverflow: TextOverflow.ellipsis,
                            text: "81",
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 58.h,
                                child: RegularText(
                                  textAlign: TextAlign.start,
                                  textSize: 9.sp,
                                  maxLines: 2,
                                  fontWeight: FontWeight.w700,
                                  textColor: AppColors.orderTitleColor,
                                  textOverflow: TextOverflow.ellipsis,
                                  text: AppTexts.onGoingOrders,
                                ),
                              ),
                              Center(
                                child: Image.asset(
                                  "assets/images/right_arrow_black.png",
                                  width: 18.w,
                                  height: 18.h,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    width: 100.w,
                    height: 84.h,
                    decoration: BoxDecoration(
                      color: AppColors.titleRedColor.withOpacity(0.10),
                      border: Border.all(
                        width: 1.w,
                        color: AppColors.titleRedColor.withOpacity(0.05),
                      ),
                      borderRadius: BorderRadius.circular(10.r),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RegularText(
                            textAlign: TextAlign.center,
                            textSize: 24.sp,
                            maxLines: 2,
                            fontWeight: FontWeight.bold,
                            textColor: AppColors.titleRedColor,
                            textOverflow: TextOverflow.ellipsis,
                            text: "20",
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: 58.h,
                                child: RegularText(
                                  textAlign: TextAlign.start,
                                  textSize: 9.sp,
                                  maxLines: 2,
                                  fontWeight: FontWeight.w700,
                                  textColor: AppColors.orderTitleColor,
                                  textOverflow: TextOverflow.ellipsis,
                                  text: "Pending Pickups",
                                ),
                              ),
                              Center(
                                child: Image.asset(
                                  "assets/images/right_arrow_black.png",
                                  width: 18.w,
                                  height: 18.h,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 40.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RegularText(
                    textAlign: TextAlign.center,
                    textSize: 14.sp,
                    maxLines: 2,
                    fontWeight: FontWeight.w700,
                    textColor: AppColors.black,
                    textOverflow: TextOverflow.ellipsis,
                    text: AppTexts.topSellingBrands,
                  ),
                  InkWell(
                    onTap: () {
                      context.push('/brands');
                    },
                    child: Row(
                      children: [
                        RegularText(
                          textAlign: TextAlign.end,
                          textSize: 12.sp,
                          maxLines: 2,
                          fontWeight: FontWeight.w700,
                          textColor: AppColors.baseColor,
                          textOverflow: TextOverflow.ellipsis,
                          text: AppTexts.viewAll,
                        ),
                        SizedBox(width: 5.w),
                        Image.asset(
                          AppAssets.rightArrow,
                          width: 20.w,
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              SizedBox(
                height: 90.h, // Constrains the ListView's height
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: imageList.length, // Dynamic item count
                  itemBuilder:
                      (BuildContext context, int index) => Padding(
                        padding: EdgeInsets.only(right: 5.w),
                        child: GestureDetector(
                          onTap: () {
                            // context.push('/explore-brands/');
                          },
                          child: Image.asset(
                            imageList[index],
                            width: 104.w,
                            height: 89.h,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                ),
              ),
              SizedBox(height: 40.h),
              RegularText(
                textAlign: TextAlign.end,
                textSize: 14.sp,
                maxLines: 2,
                fontWeight: FontWeight.w700,
                textColor: AppColors.blackNavigationColor,
                textOverflow: TextOverflow.ellipsis,
                text: AppTexts.bestDeals,
              ),
              SizedBox(height: 24.h),
              SizedBox(
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  // Let parent scroll
                  itemCount: 4,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 5.h,
                    childAspectRatio: 0.65,
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
              ),

              SizedBox(height: 32.h),
              GestureDetector(
                onTap: () {
                  context.push('/top-selling-phones');
                },
                child: Center(
                  child: Container(
                    width: 140.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4.r),
                      border: Border.all(
                        width: 1.w,
                        color: AppColors.baseColor,
                      ),
                    ),
                    child: Center(
                      child: RegularText(
                        textAlign: TextAlign.center,
                        textSize: 12.sp,
                        maxLines: 1,
                        fontWeight: FontWeight.w700,
                        textColor: AppColors.baseColor,
                        textOverflow: TextOverflow.ellipsis,
                        text: AppTexts.viewAll,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              RegularText(
                textAlign: TextAlign.end,
                textSize: 14.sp,
                maxLines: 2,
                fontWeight: FontWeight.w700,
                textColor: AppColors.black,
                textOverflow: TextOverflow.ellipsis,
                text: AppTexts.whatWeOffer,
              ),
              SizedBox(height: 24.h),
              OfferWidget(
                context: context,
                image: AppAssets.instantPayment,
                title: AppTexts.instantPaymentTitle,
                subTitle: AppTexts.instantPaymentSubTitle,
              ),
              SizedBox(height: 10.h),
              OfferWidget(
                context: context,
                image: AppAssets.bestPrice,
                title: AppTexts.bestPricesTitle,
                subTitle: AppTexts.bestPricesSubTitle,
              ),
              SizedBox(height: 10.h),
              OfferWidget(
                context: context,
                image: AppAssets.doorStep,
                title: AppTexts.pickupTitle,
                subTitle: AppTexts.pickupSubTitle,
              ),
              SizedBox(height: 10.h),
              OfferWidget(
                context: context,
                image: AppAssets.simple,
                title: AppTexts.simpleTitle,
                subTitle: AppTexts.simpleSubTitle,
              ),
              SizedBox(height: 10.h),
              OfferWidget(
                context: context,
                image: AppAssets.validPurchase,
                title: AppTexts.invoiceTitle,
                subTitle: AppTexts.invoiceSubTitle,
              ),
              SizedBox(height: 10.h),
              OfferWidget(
                context: context,
                image: AppAssets.factory,
                title: AppTexts.factoryGradeTitle,
                subTitle: AppTexts.factoryGradeSubTitle,
              ),
              SizedBox(height: 40.h),
              RegularText(
                textAlign: TextAlign.start,
                textSize: 14.sp,
                maxLines: 2,
                fontWeight: FontWeight.w700,
                textColor: AppColors.black,
                textOverflow: TextOverflow.ellipsis,
                text: AppTexts.reviewTitle,
              ),
              SizedBox(height: 24.h),
              SizedBox(
                height: 190.h,
                child: Padding(
                  padding: EdgeInsets.all(0),
                  child: ListView.builder(
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: EdgeInsets.only(right: 5.w),
                        child: Column(
                          children: [
                            Container(
                              height: 174.h,
                              width: 194.w,
                              padding: EdgeInsets.all(18.w),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0x0D2D2E39),
                                    offset: Offset(2, 4),
                                    blurRadius: 10,
                                    spreadRadius: 2, // spread
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.asset(
                                    AppAssets.quote,
                                    width: 24.w,
                                    height: 24.h,
                                  ),
                                  SizedBox(height: 18.h),
                                  RegularText(
                                    textAlign: TextAlign.center,
                                    textSize: 12.sp,
                                    maxLines: 4,
                                    fontWeight: FontWeight.w500,
                                    textColor: AppColors.orderTitleColor,
                                    textOverflow: TextOverflow.ellipsis,
                                    text: AppTexts.userReview,
                                  ),
                                  SizedBox(height: 8.h),
                                  RegularText(
                                    textAlign: TextAlign.center,
                                    textSize: 12.sp,
                                    maxLines: 1,
                                    fontWeight: FontWeight.w500,
                                    textColor: AppColors.orderTitleColor,
                                    textOverflow: TextOverflow.ellipsis,
                                    text: "~Mk",
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                    physics: ScrollPhysics(),
                    itemCount: 3,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ),
              SizedBox(height: 40.h),
              RegularText(
                textAlign: TextAlign.center,
                textSize: 14.sp,
                maxLines: 1,
                fontWeight: FontWeight.w700,
                textColor: AppColors.black,
                textOverflow: TextOverflow.ellipsis,
                text: AppTexts.frequentlyAskedQuestion,
              ),
              SizedBox(height: 24.h),
              QnAItem(
                question: AppTexts.question,
                answer: AppTexts.answer,
                isExpanded: _expandedIndex == 0,
                onTap: () => toggleExpansion(0),
              ),
              SizedBox(height: 8.h),
              QnAItem(
                question: AppTexts.question,
                answer: AppTexts.answer,
                isExpanded: _expandedIndex == 1,
                onTap: () => toggleExpansion(1),
              ),
              SizedBox(height: 8.h),
              QnAItem(
                question: AppTexts.question,
                answer: AppTexts.answer,
                isExpanded: _expandedIndex == 2,
                onTap: () => toggleExpansion(2),
              ),
              SizedBox(height: 32.h),
              Align(
                alignment: Alignment.center,
                child: RegularText(
                  textAlign: TextAlign.center,
                  textSize: 14.sp,
                  maxLines: 1,
                  fontWeight: FontWeight.w700,
                  textColor: AppColors.baseColor,
                  textOverflow: TextOverflow.ellipsis,
                  text: AppTexts.loadMore,
                ),
              ),
              SizedBox(height: 50.h),
            ],
          ),
        ),
      ),
    ),
  );

  Widget OfferWidget({
    required BuildContext context,
    required String image,
    required String title,
    required String subTitle,
  }) {
    return Container(
      height: 75.h,
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
        child: Row(
          children: [
            Image.asset(image, height: 22.h, width: 24.w, fit: BoxFit.contain),
            SizedBox(width: 20.w),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RegularText(
                  textAlign: TextAlign.end,
                  textSize: 12.sp,
                  maxLines: 1,
                  fontWeight: FontWeight.w700,
                  textColor: AppColors.black,
                  textOverflow: TextOverflow.ellipsis,
                  text: title,
                ),
                SizedBox(height: 5.h),
                RegularText(
                  textAlign: TextAlign.end,
                  textSize: 10.sp,
                  maxLines: 2,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.black,
                  textOverflow: TextOverflow.ellipsis,
                  text: subTitle,
                ),
                SizedBox(height: 5.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
