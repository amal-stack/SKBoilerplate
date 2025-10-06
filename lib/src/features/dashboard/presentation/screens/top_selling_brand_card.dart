import 'package:boilerplate/src/features/brands/domain/entities/brand.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

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
