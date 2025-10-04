import '../../domain/entities/user.dart';

/// Represents user information along with an authentication token.
class UserResponseData {
  UserResponseData({required this.user, required this.token});

  UserResponseData.fromJson(Map<String, dynamic> json)
    : user = AppUser.fromJson(json['user'] as Map<String, dynamic>),
      token = json['token'] as String;

  final AppUser user;

  final String token;

  Map<String, dynamic> toJson() => {'user': user.toJson(), 'token': token};
}

class ForgotPasswordResponseData {
  ForgotPasswordResponseData({required this.email, required this.expiresAt});

  ForgotPasswordResponseData.fromJson(Map<String, dynamic> json)
    : email = json['email'] as String,
      expiresAt = DateTime.parse(json['expiresAt'] as String);

  final String email;
  final DateTime expiresAt;

  Map<String, dynamic> toJson() => {
    'email': email,
    'expiresAt': expiresAt.toIso8601String(),
  };
}
