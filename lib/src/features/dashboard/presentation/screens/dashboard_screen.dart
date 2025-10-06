import 'package:boilerplate/src/features/brands/domain/entities/brand.dart';
import 'package:boilerplate/src/features/dashboard/domain/entities/dashboard.dart';
import 'package:boilerplate/src/features/dashboard/presentation/screens/offer_widget.dart';
import 'package:boilerplate/src/features/dashboard/presentation/screens/order_card.dart';
import 'package:boilerplate/src/features/dashboard/presentation/screens/top_selling_brand_card.dart';
import 'package:boilerplate/src/features/dashboard/presentation/screens/top_selling_product_card.dart';
import 'package:boilerplate/src/features/dashboard/presentation/screens/user_review_card.dart';
import 'package:boilerplate/src/shared/models/faq.dart';
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

class DashboardFaqs extends StatelessWidget {
  const DashboardFaqs({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewBlocSelector<DashboardCubit, Dashboard, List<Faq>>(
      selector: (state) => state.faqs,
      builder: (context, faqs) => FaqList(faqs),
    );
  }
}
