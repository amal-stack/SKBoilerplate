import 'package:meta/meta.dart';

@immutable
class Product {
  const Product({
    required this.id,
    required this.name,
    required this.brandId,
    required this.createdAt,
    required this.updatedAt,
  });

  Product.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String,
      name = json['name'] as String,
      brandId = json['brandId'] as String,
      createdAt = DateTime.parse(json['createdAt'] as String),
      updatedAt = DateTime.parse(json['updatedAt'] as String);

  final String id;

  final String name;

  final String brandId;

  final DateTime createdAt;

  final DateTime updatedAt;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'brandId': brandId,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}
