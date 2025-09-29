import 'package:boilerplate/src/features/brands/domain/entities/brand.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

const List<String> brandImageList = [
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
          Image.asset(
            brandImageList.firstWhere(
              (imagePath) => imagePath.contains(brand.name.toLowerCase()),
              orElse: () => brandImageList[0],
            ),
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
