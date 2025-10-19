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
    required this.deviceCategory,
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
      deviceCategory = switch (json['deviceCategory'] as String) {
        'android' => DeviceCategory.android,
        'ios' => DeviceCategory.ios,
        'fold' => DeviceCategory.fold,
        _ => throw ArgumentError(
          'Unknown device category: ${json['deviceCategory']}',
        ),
      },
      imageUrl = json['image'] as String;

  final String id;

  final String modelId;

  final String modelName;

  final String brandId;

  final String brandName;

  final String storage;

  final String ram;

  final DeviceCategory deviceCategory;

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

enum DeviceCategory {
  android,
  ios,
  fold;

  factory DeviceCategory.fromName(String name) => switch (name) {
    'android' => DeviceCategory.android,
    'ios' => DeviceCategory.ios,
    'fold' => DeviceCategory.fold,
    _ => throw ArgumentError('Unknown device category: $name'),
  };

  String get name => switch (this) {
    DeviceCategory.android => 'android',
    DeviceCategory.ios => 'ios',
    DeviceCategory.fold => 'fold',
  };
}

@immutable
class DevicePricing {
  final String? id;
  final String? deviceId;
  final String? vendorId;
  final String? vendorName;
  final String? grade;
  final int? price;
  final bool? available;
  final String? createdAt;
  final String? updatedAt;

  const DevicePricing({
    this.id,
    this.deviceId,
    this.vendorId,
    this.vendorName,
    this.grade,
    this.price,
    this.available,
    this.createdAt,
    this.updatedAt,
  });

  DevicePricing.fromJson(Map<String, dynamic> json)
    : id = json['id'],
      deviceId = json['deviceId'],
      vendorId = json['vendorId'],
      vendorName = json['vendorName'],
      grade = json['grade'],
      price = json['price'],
      available = json['available'],
      createdAt = json['createdAt'],
      updatedAt = json['updatedAt'];

  DevicePricing copyWith({
    String? id,
    String? deviceId,
    String? vendorId,
    String? vendorName,
    String? grade,
    int? price,
    bool? available,
    String? createdAt,
    String? updatedAt,
  }) {
    return DevicePricing(
      id: id ?? this.id,
      deviceId: deviceId ?? this.deviceId,
      vendorId: vendorId ?? this.vendorId,
      vendorName: vendorName ?? this.vendorName,
      grade: grade ?? this.grade,
      price: price ?? this.price,
      available: available ?? this.available,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'deviceId': deviceId,
    'vendorId': vendorId,
    'vendorName': vendorName,
    'grade': grade,
    'price': price,
    'available': available,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
  };
}
