import 'package:meta/meta.dart';

@immutable
class Brand {
  const Brand({
    required this.id,
    required this.name,
    required this.deviceCount,
    required this.imageUrl,
  });

  Brand.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String,
      name = json['name'] as String,
      deviceCount = json['deviceCount'] as int,
      imageUrl = json['image'] as String;

  final String id;

  final String name;

  final int deviceCount;

  final String imageUrl;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'deviceCount': deviceCount,
    'image': imageUrl,
  };
}

