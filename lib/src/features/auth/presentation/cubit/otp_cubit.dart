import 'package:boilerplate/src/features/auth/domain/entities/authentication_result.dart';

import '../../domain/repositories/auth_repository.dart';
import 'auth_cubit.dart';
import 'state.dart';

sealed class OtpState {
  const OtpState(this.email, this.message);
  final String email;
  final String message;
}

class OtpVerified extends OtpState {
  const OtpVerified(super.email, super.message, this.otp);

  final String otp;
}

class OtpResent extends OtpState {
  const OtpResent(super.email, super.message);
}

class OtpCubit extends AuthCubit<OtpState> {
  OtpCubit(this._authRepository) : super(const AuthOperationInitial());

  final AuthRepository _authRepository;

  Future<void> verifyOtp(String email, String code) async {
    loading();
    final result = await _authRepository.verifyOtp(email, code);

    if (result.isSuccess) {
      success(OtpVerified(email, result.message, code));
      return;
    }

    failure(result.message);
  }

  Future<void> resendOtp(String email) async {
    loading();
    final result = await _authRepository.sendResetEmail(email);
    if (result.isSuccess) {
      success(OtpResent(email, result.message));
      return;
    }
    failure(result.message);  
  }

  String messageFromResult(AuthenticationResult<Object?> result) =>
      result.message;
}
