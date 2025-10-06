import 'package:boilerplate/src/features/dashboard/domain/entities/dashboard.dart';
import 'package:boilerplate/src/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
