import 'package:meta/meta.dart';

@immutable
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.brandId,
    required this.deviceCount,
    required this.imageUrl,
  });

  Product.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String,
        brandId = json['brandId'] as String,
        deviceCount = json['deviceCount'] as int,
        imageUrl = json['image'] as String;

  final String id;

  final String name;

  final String brandId;

  final int deviceCount;

  final String imageUrl;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'brandId': brandId,
    'deviceCount': deviceCount,
    'image': imageUrl,
  };
}