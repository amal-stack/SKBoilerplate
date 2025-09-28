import 'package:meta/meta.dart';

@immutable
class Brand {
  const Brand({
    required this.id,
    required this.name,
    required this.createdAt,
    required this.updatedAt,
  });

  Brand.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String,
      name = json['name'] as String,
      createdAt = DateTime.parse(json['createdAt'] as String),
      updatedAt = DateTime.parse(json['updatedAt'] as String);

  final String id;

  final String name;

  final DateTime createdAt;

  final DateTime updatedAt;

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'createdAt': createdAt.toIso8601String(),
    'updatedAt': updatedAt.toIso8601String(),
  };
}

