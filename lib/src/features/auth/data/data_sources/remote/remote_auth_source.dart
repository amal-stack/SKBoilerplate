import 'package:boilerplate/src/core/network/models/api_response.dart';
import 'package:boilerplate/src/features/auth/domain/entities/authentication.dart';
import 'package:boilerplate/src/features/auth/domain/entities/user.dart';

import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/models/api_request.dart';
import '../../models/response.dart';
import '../auth_source.dart';

class RemoteAuthSource implements AuthSource {
  RemoteAuthSource(this._client);
  final ApiClient _client;

  @override
  Stream<Authentication> get authentication => _client.authentication.map(
    (status) => switch (status) {
      ApiAuthenticated(:final user) => Authentication.authenticated(
        user is AppUser ? user : null,
      ),
      ApiUnauthenticated(:final error) => Authentication.unauthenticated(error),
      ApiUnknownAuthentication() => Authentication.initial(),
    },
  );

  @override
  Future<AuthResponse> login(String email, String password) async {
    final response = await _client.post(
      ApiRequest(
        path: '/auth/login',
        data: {'email': email, 'password': password},
      ),
    );

    final authResponse = AuthResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
    final token = authResponse.data?.token;

    if (response.isSuccessStatusCode && token != null) {
      _client.saveToken(token, authResponse.data?.user);
    }

    return authResponse;
  }

  @override
  Future<void> logout() {
    return _client.clearToken();
  }

  @override
  Future<UserProfileResponse> userProfile() async {
    final response = await _client.get(const ApiRequest(path: '/auth/profile'));

    return UserProfileResponse.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<ForgotPasswordResponse> sendResetEmail(String email) async {
    final response = await _client.post(
      ApiRequest(path: '/auth/forgot-password', data: {'email': email}),
    );

    return ForgotPasswordResponse.fromJson(
      response.data as Map<String, dynamic>,
    );
  }

  @override
  Future<Response> resetPassword(
    String email,
    String code,
    String newPassword,
  ) async {
    final response = await _client.post(
      ApiRequest(
        path: '/auth/reset-password',
        data: {'email': email, 'otp': code, 'password': newPassword},
      ),
    );

    return Response.fromJson(response.data as Map<String, dynamic>);
  }

  @override
  Future<Response> verifyOtp(String email, String code) async {
    final response = await _client.post(
      ApiRequest(
        path: '/auth/validate-otp',
        data: {'email': email, 'otp': code},
      ),
    );

    return Response.fromJson(response.data as Map<String, dynamic>);
  }
}
