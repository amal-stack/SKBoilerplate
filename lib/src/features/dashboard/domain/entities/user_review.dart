import 'package:meta/meta.dart';

@immutable
class UserReview {
  const UserReview({
    required this.id,
    required this.username,
    required this.message,
  });

  UserReview.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        username = json['userName'] as String,
        message = json['message'] as String;

  final int id;

  final String username;

  final String message;

  UserReview copyWith({int? id, String? username, String? message}) =>
      UserReview(
        id: id ?? this.id,
        username: username ?? this.username,
        message: message ?? this.message,
      );

  Map<String, dynamic> toJson() => {
    'id': id,
    'userName': username,
    'message': message,
  };

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserReview &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          username == other.username &&
          message == other.message;

  @override
  int get hashCode => Object.hash(id, username, message);
}
