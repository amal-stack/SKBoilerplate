import '../entities/authentication.dart';
import '../entities/authentication_result.dart';

abstract interface class AuthRepository {

  Stream<Authentication> get state;
  
  Future<void> login(String email, String password);

  Future<void> logout();

  Future<AuthenticationResult<void>> sendResetEmail(String email);

  Future<AuthenticationResult<void>> resetPassword(String email, String code, String newPassword);

  Future<AuthenticationResult<void>> verifyOtp(String email, String code);

  void dispose();
}
