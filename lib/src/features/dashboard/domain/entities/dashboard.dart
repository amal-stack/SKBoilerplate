import 'package:boilerplate/src/features/brands/domain/entities/brand.dart';
import 'package:boilerplate/src/features/dashboard/domain/entities/faq.dart';
import 'package:boilerplate/src/features/dashboard/domain/entities/order_metrics.dart';
import 'package:boilerplate/src/features/dashboard/domain/entities/user_review.dart';
import 'package:meta/meta.dart';

class Dashboard {
  const Dashboard({
    required this.orderMetrics,
    required this.topSellingBrands,
    required this.topSellingProducts,
    required this.userReviews,
    required this.faqs,
  });

  Dashboard.fromJson(Map<String, dynamic> json)
    : orderMetrics = OrderMetrics.fromJson(json['data']),
      topSellingBrands = [
        for (final brand in (json['data']['topSellingBrands'] as List<dynamic>))
          Brand.fromJson(brand as Map<String, dynamic>),
      ],
      topSellingProducts = [
        for (final product in (json['data']['topSelling'] as List<dynamic>))
          TopSellingProduct.fromJson(product as Map<String, dynamic>),
      ],
      userReviews = [
        for (final review in (json['userReviews'] as List<dynamic>))
          UserReview.fromJson(review as Map<String, dynamic>),
      ],
      faqs = [
        for (final faq in (json['faqs'] as List<dynamic>))
          Faq.fromJson(faq as Map<String, dynamic>),
      ];

  final OrderMetrics orderMetrics;

  final List<Brand> topSellingBrands;

  final List<TopSellingProduct> topSellingProducts;

  final List<UserReview> userReviews;

  final List<Faq> faqs;

  Dashboard copyWith({
    OrderMetrics? orderMetrics,
    List<Brand>? topSellingBrands,
    List<TopSellingProduct>? topSellingProducts,
    List<UserReview>? userReviews,
    List<Faq>? faqs,
  }) => Dashboard(
    orderMetrics: orderMetrics ?? this.orderMetrics,
    topSellingBrands: topSellingBrands ?? this.topSellingBrands,
    topSellingProducts: topSellingProducts ?? this.topSellingProducts,
    userReviews: userReviews ?? this.userReviews,
    faqs: faqs ?? this.faqs,
  );

  Map<String, dynamic> toJson() => {
    ...orderMetrics.toJson(),
    'data': {
    'topSellingBrands': [for (final brand in topSellingBrands) brand.toJson()],
    'topSelling': [for (final product in topSellingProducts) product.toJson()],
    },
    'userReviews': [for (final review in userReviews) review.toJson()],
    'faqs': [for (final faq in faqs) faq.toJson()],
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Dashboard &&
          runtimeType == other.runtimeType &&
          orderMetrics == other.orderMetrics &&
          topSellingBrands == other.topSellingBrands &&
          topSellingProducts == other.topSellingProducts &&
          userReviews == other.userReviews &&
          faqs == other.faqs;

  @override
  int get hashCode => Object.hash(
    orderMetrics,
    Object.hashAll(topSellingBrands),
    Object.hashAll(topSellingProducts),
    Object.hashAll(userReviews),
    Object.hashAll(faqs),
  );
}

@immutable
class TopSellingProduct {
  const TopSellingProduct({
    required this.id,
    required this.brand,
    required this.model,
    required this.ram,
    required this.storage,
    required this.imageUrl,
  });

  TopSellingProduct.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String,
      brand = json['brand'] as String,
      model = json['model'] as String,
      ram = json['ram'] as String,
      storage = json['storage'] as String,
      imageUrl = json['image'] as String;
  final String id;

  final String brand;

  final String model;

  final String ram;

  final String storage;

  final String imageUrl;

  Map<String, dynamic> toJson() => {
    'id': id,
    'brand': brand,
    'model': model,
    'ram': ram,
    'storage': storage,
    'image': imageUrl,
  };
}