import 'package:meta/meta.dart';

@immutable
class ProductVariant {
  const ProductVariant({
    required this.id,
    required this.modelId,
    required this.modelName,
    required this.brandId,
    required this.brandName,
    required this.storage,
    required this.ram,
    required this.imageUrl,
  });

  ProductVariant.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String,
      modelId = json['modelId'] as String,
      modelName = json['modelName'] as String,
      brandId = json['brandId'] as String,
      brandName = json['brandName'] as String,
      storage = json['storage'] as String,
      ram = json['ram'] as String,
      imageUrl = json['image'] as String;

  final String id;

  final String modelId;

  final String modelName;

  final String brandId;

  final String brandName;

  final String storage;

  final String ram;

  final String imageUrl;

  Map<String, dynamic> toJson() => {
    'id': id,
    'modelId': modelId,
    'modelName': modelName,
    'brandId': brandId,
    'brandName': brandName,
    'storage': storage,
    'ram': ram,
    'image': imageUrl,
  };
} 