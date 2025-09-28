import '../../domain/repositories/auth_repository.dart';
import 'auth_cubit.dart';
import 'state.dart';

class OtpCubit extends AuthCubit<void> {
  OtpCubit(this._authRepository) : super(const AuthOperationInitial());

  final AuthRepository _authRepository;

  Future<void> verifyOtp(String email, String code) async {
    loading();
    final result = await _authRepository.verifyOtp(email, code);
    emit(AuthCubit.stateWithMessageFromResult(result));
  }
}
