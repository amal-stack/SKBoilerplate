import 'package:boilerplate/src/features/brands/domain/entities/brand.dart';
import 'package:boilerplate/src/features/dashboard/domain/entities/dashboard.dart';
import 'package:boilerplate/src/features/dashboard/domain/entities/faq.dart';
import 'package:boilerplate/src/features/dashboard/domain/entities/order_metrics.dart';
import 'package:boilerplate/src/features/dashboard/domain/entities/user_review.dart';
import 'package:boilerplate/src/features/dashboard/presentation/cubits/dashboard_cubit.dart';
import 'package:boilerplate/src/features/dashboard/presentation/screens/faq_screen.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_assets.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/sign_out_connfirmation_sheet.dart';

import 'package:boilerplate/src/shared/widgets/view_bloc_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';



class DashboardScreen extends StatefulWidget {
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
  Widget build(BuildContext context) => BlocProvider(
    lazy: false,
    create: (context) => DashboardCubit(context.read())..fetchDashboardData(),
    child: Scaffold(
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
                        SizedBox(width: 8.w),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) =>
                                  const SignOutConfirmationSheet(),
                            );
                          },
                          child: Icon(Icons.logout_outlined, size: 22.w),
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
                ViewBlocSelector<DashboardCubit, Dashboard, OrderMetrics>(
                  selector: (state) => state.orderMetrics,
                  builder: (context, orderMetrics) => OrderCards(orderMetrics),
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
                  child:
                      ViewBlocSelector<DashboardCubit, Dashboard, List<Brand>>(
                        selector: (state) => state.topSellingBrands,
                        builder: (context, topSellingBrands) =>
                            ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: topSellingBrands.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  TopSellingBrandCard(topSellingBrands[index]),
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
                const TopSellingProducts(),

                SizedBox(height: 32.h),
                ViewAllTopSellingDevicesButton(),
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
                  image: AppAssets.instantPayment,
                  title: AppTexts.instantPaymentTitle,
                  subtitle: AppTexts.instantPaymentSubTitle,
                ),
                SizedBox(height: 10.h),
                OfferWidget(
                  image: AppAssets.bestPrice,
                  title: AppTexts.bestPricesTitle,
                  subtitle: AppTexts.bestPricesSubTitle,
                ),
                SizedBox(height: 10.h),
                OfferWidget(
                  image: AppAssets.doorStep,
                  title: AppTexts.pickupTitle,
                  subtitle: AppTexts.pickupSubTitle,
                ),
                SizedBox(height: 10.h),
                OfferWidget(
                  image: AppAssets.simple,
                  title: AppTexts.simpleTitle,
                  subtitle: AppTexts.simpleSubTitle,
                ),
                SizedBox(height: 10.h),
                OfferWidget(
                  image: AppAssets.validPurchase,
                  title: AppTexts.invoiceTitle,
                  subtitle: AppTexts.invoiceSubTitle,
                ),
                SizedBox(height: 10.h),
                OfferWidget(
                  image: AppAssets.factory,
                  title: AppTexts.factoryGradeTitle,
                  subtitle: AppTexts.factoryGradeSubTitle,
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
                DashboardUserReviews(),
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
                DashboardFaqs(),
                SizedBox(height: 32.h),
                GestureDetector(
                  onTap: () {
                    context.go('/dashboard/faqs');
                  },
                  child: Align(
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
                ),
                SizedBox(height: 50.h),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class ViewAllTopSellingDevicesButton extends StatelessWidget {
  const ViewAllTopSellingDevicesButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/top-selling-phones');
      },
      child: Center(
        child: Container(
          width: 140.w,
          height: 40.h,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(width: 1.w, color: AppColors.baseColor),
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
    );
  }
}

class TopSellingProducts extends StatelessWidget {
  const TopSellingProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewBlocSelector<DashboardCubit, Dashboard, List<TopSellingProduct>>(
      selector: (state) => state.topSellingProducts,
      builder: (context, products) => SizedBox(
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
          itemBuilder: (context, index) =>
              TopSellingProductCard(products[index]),
        ),
      ),
    );
  }
}

class DashboardUserReviews extends StatelessWidget {
  const DashboardUserReviews({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewBlocSelector<DashboardCubit, Dashboard, List<UserReview>>(
      selector: (state) => state.userReviews,
      builder: (context, reviews) => SizedBox(
        height: 190.h,
        child: Padding(
          padding: EdgeInsets.all(0),
          child: ListView.builder(
            physics: ScrollPhysics(),
            itemCount: reviews.length,
            shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return UserReviewCard(reviews[index]);
            },
          ),
        ),
      ),
    );
  }
}

class UserReviewCard extends StatelessWidget {
  const UserReviewCard(this.review, {super.key});

  final UserReview review;

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(AppAssets.quote, width: 24.w, height: 24.h),
                SizedBox(height: 18.h),
                RegularText(
                  textAlign: TextAlign.center,
                  textSize: 12.sp,
                  maxLines: 4,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.orderTitleColor,
                  textOverflow: TextOverflow.ellipsis,
                  text: review.message,
                ),
                SizedBox(height: 8.h),
                RegularText(
                  textAlign: TextAlign.center,
                  textSize: 12.sp,
                  maxLines: 1,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.orderTitleColor,
                  textOverflow: TextOverflow.ellipsis,
                  text: '~${review.username}',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class TopSellingProductCard extends StatelessWidget {
  const TopSellingProductCard(this.product, {super.key});

  final TopSellingProduct product;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push('/phone-details/${product.id}');
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
                  child: Image.network(
                    product.imageUrl,
                    height: 100.h,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.h),
                child: RegularText(
                  text: product.model,
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
                padding: EdgeInsets.symmetric(horizontal: 12.h),
                child: RegularText(
                  text: '${product.storage} / ${product.ram}',
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
                padding: EdgeInsets.symmetric(horizontal: 12.h),
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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.h),
                    child: RegularText(
                      text: "₹ 48,000",
                      textAlign: TextAlign.start,
                      textSize: 12.sp,
                      fontWeight: FontWeight.w700,
                      textColor: AppColors.darkGreenColor,
                    ),
                  ),
                  const BestPriceTag(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class BestPriceTag extends StatelessWidget {
  const BestPriceTag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 66.w,
      height: 20.h,
      decoration: BoxDecoration(
        color: AppColors.darkGreenColor,
        border: Border.all(
          width: 1.w,
          color: AppColors.borderBlack.withValues(alpha: 0.1),
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
    );
  }
}

class TopSellingBrandCard extends StatelessWidget {
  const TopSellingBrandCard(this.brand, {super.key});

  final Brand brand;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(right: 5.w),
      child: GestureDetector(
        onTap: () {
          context.push('/explore-brands/${brand.id}');
        },
        child: Image.network(
          brand.imageUrl,
          width: 104.w,
          height: 89.h,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}

class OfferWidget extends StatelessWidget {
  const OfferWidget({
    super.key,
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;

  final String title;

  final String subtitle;

  @override
  Widget build(BuildContext context) {
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
                  text: subtitle,
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

class OrderCards extends StatelessWidget {
  const OrderCards(this.metrics, {super.key});

  final OrderMetrics metrics;

  @override
  Widget build(BuildContext context) => Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      // context.push('/top-selling-phones');
      OrderCard(
        onTap: () {
          context.push('/order-history-screen');
        },
        color: AppColors.lightBorderColor.withValues(alpha: 0.13),
        borderColor: AppColors.lightBorderColor.withValues(alpha: 0.13),
        titleColor: AppColors.lightGreenColor,
        title: AppTexts.onGoingOrders,
        value: metrics.ongoingOrders,
      ),
      SizedBox(width: 8.w),
      OrderCard(
        color: AppColors.skyBlueColor.withValues(alpha: 0.27),
        borderColor: AppColors.skyBlueColor.withValues(alpha: 0.10),
        titleColor: AppColors.darkSkyBlueTitleColor,
        title: AppTexts.completedOrders,
        value: metrics.completedOrders,
      ),
      SizedBox(width: 8.w),
      OrderCard(
        onTap: () {
          context.push('/pending-order-screen');
        },
        color: AppColors.titleRedColor.withValues(alpha: 0.10),
        borderColor: AppColors.titleRedColor.withValues(alpha: 0.05),
        titleColor: AppColors.titleRedColor,
        title: 'Pending Pickups',
        value: metrics.pendingOrders,
      ),
      SizedBox(width: 8.w),
    ],
  );
}

class OrderCard extends StatelessWidget {
  const OrderCard({
    super.key,
    this.onTap,
    required this.color,
    required this.borderColor,
    required this.titleColor,
    required this.title,
    required this.value,
  });

  final VoidCallback? onTap;

  final Color color;

  final Color borderColor;

  final Color titleColor;

  final String title;

  final int value;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      width: 100.w,
      height: 84.h,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(width: 1.w, color: borderColor),
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
              textColor: titleColor,
              textOverflow: TextOverflow.ellipsis,
              text: "$value",
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
                    text: title,
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
  );
}

class DashboardFaqs extends StatelessWidget {
  const DashboardFaqs({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewBlocSelector<DashboardCubit, Dashboard, List<Faq>>(
      selector: (state) => state.faqs,
      builder: (context, faqs) => SizedBox(height: 200.h, child: FaqList(faqs)),
    );
  }
}
