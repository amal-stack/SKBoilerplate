import 'package:boilerplate/src/features/brands/domain/entities/brand.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BrandCard extends StatelessWidget {
  const BrandCard({super.key, required this.brand});

  final Brand brand;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () {
      context.push('/explore-brands/${brand.id}');
    },
    child: Container(
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppColors.borderBlack.withValues(alpha: 0.10),
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10.h),
          Image.network(
            brand.imageUrl,
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
            text: brand.name,
          ),
        ],
      ),
    ),
  );
}
