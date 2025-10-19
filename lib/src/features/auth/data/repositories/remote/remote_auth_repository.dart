import 'dart:async';

import '../../../../../core/network/models/api_exception.dart';
import '../../../domain/entities/authentication.dart';
import '../../../domain/entities/authentication_result.dart';
import '../../../domain/repositories/auth_repository.dart';
import '../../data_sources/auth_source.dart';
import '../../models/response.dart';

class RemoteAuthRepository implements AuthRepository {
  RemoteAuthRepository(this._auth);

  final AuthSource _auth;

  @override
  Stream<Authentication> get state => _auth.authentication;

  @override
  Future<void> login(String email, String password) async {
    _runWithErrorHandling(() => _auth.login(email, password));

    // try {
    //   final response = await _auth.login(email, password);
    //   switch (response) {
    //     case AuthResponse(success: true, data: final UserResponseData? data):
    //       _controller.add(Authentication.authenticated(data?.user));
    //     case AuthResponse(success: false, message: final message):
    //       _controller.add(Authentication.unauthenticated(message));
    //     default:
    //       _controller.add(
    //         const Authentication.unauthenticated('Unknown error'),
    //       );
    //   }
    // } on ApiException catch (e) {
    //   _controller.add(Authentication.unauthenticated(e.message, e));
    // }
  }

  @override
  Future<void> logout() async {
    _auth.logout();
  }

  @override
  Future<AuthenticationResult<void>> sendResetEmail(String email) =>
      _runWithErrorHandling(() => _auth.sendResetEmail(email));

  @override
  Future<AuthenticationResult<void>> resetPassword(
    String email,
    String code,
    String newPassword,
  ) => _runWithErrorHandling(
    () => _auth.resetPassword(email, code, newPassword),
  );

  @override
  Future<AuthenticationResult<void>> verifyOtp(String email, String code) =>
      _runWithErrorHandling(() => _auth.verifyOtp(email, code));

  AuthenticationResult<T> _responseToResult<T>(Response response) =>
      switch (response) {
        Response(success: true, message: final message) =>
          AuthenticationResult.success(message: message),

        Response(success: false, message: final message) =>
          AuthenticationResult.failure(message: message),
      };

  Future<AuthenticationResult<T>> _runWithErrorHandling<T>(
    Future<Response> Function() action,
  ) async {
    try {
      return await action().then(_responseToResult);
    } on ApiException catch (e) {
      return AuthenticationResult.failure(message: e.message);
    }
  }

  @override
  void dispose() {}
}
