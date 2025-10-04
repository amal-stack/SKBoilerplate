import 'package:meta/meta.dart';

/// User entity representing an application user.
@immutable
class AppUser {
  const AppUser({
    required this.id,
    required this.email,
    required this.name,
    required this.createdAt,
  });

  AppUser.fromJson(Map<String, dynamic> json)
    : id = json['id'] as String,
      email = json['email'] as String,
      name = json['name'] as String,
      createdAt = DateTime.parse(json['createdAt'] as String);

  final String id;

  final String email;

  final String name;

  final DateTime createdAt;

  Map<String, dynamic> toJson() => {
      'id': id,
      'email': email,
      'name': name,
      'createdAt': createdAt.toIso8601String(),
    };

  AppUser copyWith({
    String? id,
    String? email,
    String? name,
    DateTime? createdAt,
  }) => AppUser(
    id: id ?? this.id,
    email: email ?? this.email,
    name: name ?? this.name,
    createdAt: createdAt ?? this.createdAt,
  );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AppUser &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          email == other.email &&
          name == other.name &&
          createdAt == other.createdAt;

  @override
  int get hashCode => Object.hash(id, email, name, createdAt);
}
