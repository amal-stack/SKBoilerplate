import 'package:boilerplate/src/features/brands/domain/entities/brand.dart';
import 'package:boilerplate/src/features/brands/presentation/cubit/brands_cubit.dart';
import 'package:boilerplate/src/features/brands/presentation/widgets/brand_card.dart';
import 'package:boilerplate/src/shared/paginated.dart';
import 'package:boilerplate/src/shared/widgets/view_bloc_builder.dart';
import 'package:flutter/material.dart';

class BrandsGrid extends StatelessWidget {
  const BrandsGrid({super.key});

  @override
  Widget build(BuildContext context) =>
      ViewBlocBuilder<BrandsCubit, Paginated<Brand>>(
        builder: (context, brands) => SingleChildScrollView(
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
      );
}
