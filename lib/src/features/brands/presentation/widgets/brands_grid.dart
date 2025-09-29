import 'package:boilerplate/src/features/brands/presentation/cubit/brands_cubit.dart';
import 'package:boilerplate/src/features/brands/presentation/widgets/brand_card.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BrandsGrid extends StatelessWidget {
  const BrandsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BrandsCubit, BrandsState>(
      builder: (context, state) => switch (state) {
        BrandsInitial() => const Center(child: Text("No brands loaded")),
        BrandsLoading() => const Center(child: CircularProgressIndicator()),
        BrandsError(:final message) => SingleChildScrollView(
          child: Center(
            child: RegularText(
              text:
                  "Failed to load brands. ${kDebugMode ? "Cause: $message" : ""}",
              textColor: AppColors.errorColor,
              textSize: 16.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        BrandsFetched(:final brands) => SingleChildScrollView(
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: brands.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3, // 3 per row
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) => BrandCard(brand: brands[index]),
          ),
        ),
      },
    );
  }
}
