import 'package:boilerplate/src/core/models/data_response.dart';

import '../../domain/entities/user.dart';
import 'response_data.dart';

export '../../../../core/models/response.dart';

/// Represents a response from the authentication data source.
class AuthResponse extends DataResponse<UserResponseData> {
  const AuthResponse({
    required super.success,
    required super.message,
    required super.data,
  });

  AuthResponse.fromJson(Map<String, dynamic> json)
    : super.fromJson(json, UserResponseData.fromJson);

  @override
  Map<String, dynamic> dataToJson(UserResponseData data) => data.toJson();
}

/// Represents a response containing user profile information.
class UserProfileResponse extends DataResponse<AppUser> {
  UserProfileResponse({
    required super.success,
    required super.message,
    required super.data,
  });

  UserProfileResponse.fromJson(Map<String, dynamic> json)
    : super.fromJson(json, AppUser.fromJson);

  @override
  Map<String, dynamic> dataToJson(AppUser data) => data.toJson();
}

class ForgotPasswordResponse extends DataResponse<ForgotPasswordResponseData> {
  const ForgotPasswordResponse({
    required super.success,
    required super.message,
    required super.data,
  });

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json)
    : super.fromJson(json, ForgotPasswordResponseData.fromJson);

  @override
  Map<String, dynamic> dataToJson(ForgotPasswordResponseData data) =>
      data.toJson();
}
