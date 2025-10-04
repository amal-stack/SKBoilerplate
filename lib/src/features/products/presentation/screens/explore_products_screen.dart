import 'package:boilerplate/src/features/products/domain/product.dart';
import 'package:boilerplate/src/features/products/presentation/cubits/products_cubit.dart';
import 'package:boilerplate/src/shared/themes/text.dart';
import 'package:boilerplate/src/shared/utils/app_colors.dart';
import 'package:boilerplate/src/shared/utils/app_texts.dart';
import 'package:boilerplate/src/shared/utils/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:boilerplate/src/shared/widgets/custom_text_field.dart';

class ExploreProductsScreen extends StatelessWidget {
  const ExploreProductsScreen({super.key, required this.brandId});

  final String brandId;

  @override
  Widget build(BuildContext context) => BlocProvider(
    lazy: false,
    create: (context) =>
        ProductsCubit(context.read())..fetchProducts(brandId: brandId),
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
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
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
                  text: AppTexts.exploreAppleProducts,
                ),
                SizedBox(height: 8.h),
                RegularText(
                  textAlign: TextAlign.center,
                  textSize: 12.sp,
                  maxLines: 1,
                  fontWeight: FontWeight.w500,
                  textColor: AppColors.borderBlack,
                  textOverflow: TextOverflow.ellipsis,
                  text: AppTexts.modelOffers,
                ),
                SizedBox(height: 24.h),
                InputTextField(
                  label: "Search for Phone",
                  hintMessage: "Search for Phone",
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
                SizedBox(height: 22.h),
                ProductsGrid(),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) => switch (state) {
        ProductsInitial() => const Text("No products loaded"),
        ProductsLoading() => const Center(child: CircularProgressIndicator()),
        ProductsError(message: var message) => Center(
          child: Text('Error: $message'),
        ),
        ProductsFetched(products: var products) => SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics: ScrollPhysics(),
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3, // 3 per row
                  crossAxisSpacing: 8.w, // horizontal spacing
                  mainAxisSpacing: 12.h, // vertical spacing
                  childAspectRatio: 0.85,
                ),
                itemBuilder: (context, index) => ProductCard(products[index]),
              ),
            ],
          ),
        ),
      },
    );
  }
}


class ProductCard extends StatelessWidget {
  const ProductCard(this.product, {super.key});

  final Product product;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () {
      context.push('/phone-details/${product.id}');
    },
    child: Container(
      padding: EdgeInsets.all(8.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.borderBlack.withOpacity(0.10)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(
            product.imageUrl,
            height: 60.h,
            width: 60.w,
            fit: BoxFit.contain,
          ),
          SizedBox(height: 8.h),
          RegularText(
            textAlign: TextAlign.center,
            textSize: 12.sp,
            maxLines: 1,
            fontWeight: FontWeight.w500,
            textColor: AppColors.black,
            textOverflow: TextOverflow.ellipsis,
            text: product.name,
          ),
        ],
      ),
    ),
  );
}
