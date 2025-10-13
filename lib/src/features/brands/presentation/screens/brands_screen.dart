import 'package:boilerplate/src/features/brands/domain/repositories/brands_repository.dart';
import 'package:boilerplate/src/features/brands/presentation/cubit/brands_cubit.dart';
import 'package:boilerplate/src/features/brands/presentation/widgets/brands_grid.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/utils/app_assets.dart';
import 'package:boilerplate/src/shared/widgets/search_input_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class BrandsScreen extends StatelessWidget {
  const BrandsScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    lazy: false,
    create: (context) =>
        BrandsCubit(context.read<BrandsRepository>())..fetchBrands(),
    child: Scaffold(
      resizeToAvoidBottomInset: false,
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
              SizedBox(height: 8.h),
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
              BrandsSearchInput(),
              SizedBox(height: 22.h),
              Expanded(child: const BrandsGrid()),
            ],
          ),
        ),
      ),
    ),
  );
}

class BrandsSearchInput extends StatelessWidget {
  const BrandsSearchInput({super.key});

  @override
  Widget build(BuildContext context) => SearchInputField(
    label: "Search for Brand",
    onChanged: (value) {
      context.read<BrandsCubit>().searchBrandsWithDebounce(value);
    },
  );
}
