import '../../domain/entities/authentication_result.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_cubit.dart';
import 'state.dart';

class ForgotPasswordCubit extends AuthCubit<ForgotPasswordDetails> {
  ForgotPasswordCubit(this._authRepository)
    : super(const AuthOperationInitial<ForgotPasswordDetails>());

  final AuthRepository _authRepository;

  Future<void> forgotPassword(String email) async {
    loading();
    final result = await _authRepository.sendResetEmail(email);

    emit(stateFromResult(email, result));
  }

  AuthOperationState<ForgotPasswordDetails> stateFromResult(
    String email,
    AuthenticationResult<Object?> result,
  ) => switch (result) {
    AuthenticationResult(isSuccess: true, message: final message) =>
      AuthOperationSuccess(ForgotPasswordDetails(email, message)),
    AuthenticationResult(isSuccess: false, message: final message) =>
      AuthOperationFailure(message),
  };
}

class ForgotPasswordDetails {
  const ForgotPasswordDetails(this.email, this.message);

  final String email;
  final String message;
}
