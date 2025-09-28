
import '../../domain/repositories/auth_repository.dart';
import 'auth_cubit.dart';
import 'state.dart';



class ResetPasswordCubit extends AuthCubit<String> {
  ResetPasswordCubit(this._authRepository)
    : super(const AuthOperationInitial<String>());

  final AuthRepository _authRepository;

  Future<void> resetPassword(
    String email,
    String code,
    String newPassword,
  ) async {
    loading();
    final result = await _authRepository.resetPassword(
      email,
      code,
      newPassword,
    );

    emit(AuthCubit.stateWithMessageFromResult(result));
  }
}
