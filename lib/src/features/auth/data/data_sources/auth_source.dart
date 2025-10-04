import '../models/response.dart';


abstract interface class AuthSource {
  Future<AuthResponse> login(String email, String password);

  Future<void> logout();

  Future<UserProfileResponse> userProfile();

  Future<ForgotPasswordResponse> sendResetEmail(String email);

  Future<Response> resetPassword(String email, String code, String newPassword);

  Future<Response> verifyOtp(String email, String code);
}