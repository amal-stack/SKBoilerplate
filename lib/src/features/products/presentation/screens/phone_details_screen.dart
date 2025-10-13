import 'package:boilerplate/src/features/dashboard/presentation/screens/faq_screen.dart';
import 'package:boilerplate/src/features/introslider/widgets/indicator.dart';
import 'package:boilerplate/src/features/products/domain/product_variant.dart';
import 'package:boilerplate/src/features/products/presentation/cubits/variants_cubit.dart';
import 'package:boilerplate/src/shared/models/faq.dart';
import 'package:boilerplate/src/shared/themes/text.dart' as custom;
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_assets.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../shared/widgets/animated_button.dart';

class PhoneDetailsScreen extends StatefulWidget {
  const PhoneDetailsScreen({super.key, required this.modelId});

  final String modelId;

  @override
  State<PhoneDetailsScreen> createState() => _PhoneDetailsScreenState();
}

class _PhoneDetailsScreenState extends State<PhoneDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      lazy: false,
      create: (context) =>
          ProductVariantsCubit(context.read())
            ..fetchVariants(modelId: widget.modelId),
      child: Scaffold(
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

          actions: [
            Row(
              children: [
                Image.asset(AppAssets.location, width: 24.w, height: 24.h),
                SizedBox(width: 5.w),
                Image.asset(AppAssets.notification, width: 24.w, height: 24.h),
                SizedBox(width: 5.w),
                Image.asset(AppAssets.menu, width: 24.w, height: 24.h),
                SizedBox(width: 16.w),
              ],
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Container(color: AppColors.dividerColor, height: 1),
          ),
        ),
        body: BlocBuilder<ProductVariantsCubit, ProductVariantsState>(
          builder: (context, state) => switch (state) {
            ProductVariantsInitial() => Center(
              child: CircularProgressIndicator(color: AppColors.baseColor),
            ),
            ProductVariantsFetched(:final variants) =>
              variants.isEmpty
                  ? Center(
                      child: RegularText(
                        text: "No variants available",
                        textColor: AppColors.black,
                        fontWeight: FontWeight.w500,
                        textSize: 16.sp,
                      ),
                    )
                  : _PhoneDetailsBody(variants: variants),
            ProductVariantsError(:final message) => Center(
              child: Text(message, style: TextStyle(color: Colors.red)),
            ),
          },
        ),
      ),
    );
  }
}

class _PhoneDetailsBody extends StatefulWidget {
  const _PhoneDetailsBody({required this.variants});

  final List<ProductVariant> variants;

  @override
  State<_PhoneDetailsBody> createState() => _PhoneDetailsBodyState();
}

class _PhoneDetailsBodyState extends State<_PhoneDetailsBody> {
  final PageController _controller = PageController();
  int get _selectedIndex => _page ?? 0;
  int? _page;
  int? _expandedIndex;

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onPageChanged);
  }

  void _onPageChanged() {
    final newIndex = _controller.page?.round();
    if (newIndex != null && newIndex != _selectedIndex) {
      setState(() {
        _page = newIndex;
      });
    }
  }

  void toggleExpansion(int index) {
    setState(() {
      if (_expandedIndex == index) {
        _expandedIndex = null; // collapse
      } else {
        _expandedIndex = index; // expand selected
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              SizedBox(
                height: 230.h,
                child: PageView.builder(
                  controller: _controller,

                  itemCount: widget.variants.length,
                  itemBuilder: (_, index) {
                    return Padding(
                      padding: EdgeInsets.all(20.w),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.network(
                            widget.variants[index].imageUrl,
                            fit: BoxFit.fitHeight,
                            width: 320.w,
                            height: 170.h,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              IntroSliderPageIndicator(
                controller: _controller,
                length: widget.variants.length,
              ),
              SizedBox(height: 20.h),
              if (widget.variants.isNotEmpty)
                RegularText(
                  textAlign: TextAlign.start,
                  textSize: 20.sp,
                  maxLines: 1,
                  fontWeight: FontWeight.w700,
                  textColor: AppColors.black,
                  textOverflow: TextOverflow.ellipsis,
                  text: widget.variants[_selectedIndex].modelName,
                ),
              SizedBox(height: 20.h),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: List.generate(widget.variants.length, (index) {
                  return GestureDetector(
                    onTap: () {
                      _controller.animateToPage(
                        index,
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    },
                    child: Container(
                      width: 69.w,
                      height: 39.h,
                      decoration: BoxDecoration(
                        color: _selectedIndex == index
                            ? AppColors.lightBorderColor
                            : AppColors.white,
                        borderRadius: BorderRadius.circular(4.r),
                        border: Border.all(
                          width: 1.w,
                          color: _selectedIndex == index
                              ? AppColors.lightBorderColor
                              : AppColors.borderBlack.withValues(alpha: 0.10),
                        ),
                      ),
                      child: Center(
                        child: RegularText(
                          textAlign: TextAlign.start,
                          textSize: 12.sp,
                          maxLines: 1,
                          fontWeight: _selectedIndex == index
                              ? FontWeight.w600
                              : FontWeight.w500,
                          textColor: AppColors.borderBlack,
                          textOverflow: TextOverflow.ellipsis,
                          text: widget.variants[index].storage,
                        ),
                      ),
                    ),
                  );
                }),
              ),
              SizedBox(height: 20.h),
              custom.RichText(
                texts: [
                  TextModel(
                    AppTexts.getUpTo,
                    size: 12.sp,
                    fontWeight: FontWeight.w600,
                    color: AppColors.black,
                  ),
                  TextModel(
                    " ₹ 48,000",
                    size: 24.sp,
                    fontWeight: FontWeight.w700,
                    color: AppColors.borderBlack,
                  ),
                ],
                maxLines: 3,
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 45.h,
                width: double.infinity,
                child: AnimatedButton(
                  disableButton: widget.variants.isEmpty,
                  isLoading: false,
                  onPressed: () {
                    context.push('/imei/${widget.variants[_selectedIndex].id}');
                  },
                  label: AppTexts.quickQuote,
                  fontSize: 12.sp,
                  isSmallButton: false,
                ),
              ),
              SizedBox(height: 40.h),
              RegularText(
                textAlign: TextAlign.start,
                textSize: 14.sp,
                maxLines: 2,
                fontWeight: FontWeight.w700,
                textColor: AppColors.blackNavigationColor,
                textOverflow: TextOverflow.ellipsis,
                text: AppTexts.frequentlyAskedQuestion,
              ),
              SizedBox(height: 20.h),
              FaqList(
                List.filled(
                  2,
                  Faq(
                    id: -1,
                    question: AppTexts.question,
                    answer: AppTexts.answer,
                  ),
                ),
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
                textColor: AppColors.blackNavigationColor,
                textOverflow: TextOverflow.ellipsis,
                text: "Top Selling iPhones ",
              ),
              SizedBox(height: 20.h),
              SizedBox(
                //height: 400.h,
                child: GridView.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  physics: ScrollPhysics(),
                  itemCount: 4,
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, // 2 images in one row
                    crossAxisSpacing: 10.w, // horizontal space
                    childAspectRatio: 0.65,
                    mainAxisSpacing: 05.h, // vertical space
                  ),
                  itemBuilder: (context, index) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x0D2D2E39),
                          offset: Offset(2, 4),
                          blurRadius: 10,
                          spreadRadius: 2, // spread
                        ),
                      ],
                    ),

                    child: SizedBox(
                      child: Padding(
                        padding: EdgeInsets.all(12.w),
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
                            SizedBox(height: 15.h),
                            RegularText(
                              textAlign: TextAlign.end,
                              textSize: 12.sp,
                              maxLines: 2,
                              fontWeight: FontWeight.w700,
                              textColor: AppColors.black,
                              textOverflow: TextOverflow.ellipsis,
                              text: "Iphone 16 Pro",
                            ),
                            SizedBox(height: 8.h),
                            RegularText(
                              textAlign: TextAlign.end,
                              textSize: 10.sp,
                              maxLines: 2,
                              fontWeight: FontWeight.w600,
                              textColor: AppColors.greyColor,
                              textOverflow: TextOverflow.ellipsis,
                              text: "126 GB / 256 GB",
                            ),

                            SizedBox(height: 8.h),
                            RegularText(
                              textAlign: TextAlign.end,
                              textSize: 8.sp,
                              maxLines: 2,
                              fontWeight: FontWeight.w700,
                              textColor: AppColors.black,
                              textOverflow: TextOverflow.ellipsis,
                              text: "Get Upto",
                            ),
                            SizedBox(height: 8.h),
                            RegularText(
                              textAlign: TextAlign.end,
                              textSize: 12.sp,
                              maxLines: 2,
                              fontWeight: FontWeight.w700,
                              textColor: AppColors.black,
                              textOverflow: TextOverflow.ellipsis,
                              text: "₹ 48,000",
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

              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  RegularText(
                    textAlign: TextAlign.end,
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
                          "assets/images/right_arrow.png",
                          width: 20.w,
                          height: 20.h,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 90.h, // Constrains the ListView's height
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: widget.variants.length, // Dynamic item count
                  itemBuilder: (BuildContext context, int index) => Padding(
                    padding: EdgeInsets.only(right: 5.w),
                    // Spacing between items
                    child: Image.network(
                      widget.variants[index].imageUrl,
                      width: 104.w,
                      height: 89.h,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20.h),
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
    );
  }
}

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
