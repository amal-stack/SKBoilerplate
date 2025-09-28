import 'package:flutter_bloc/flutter_bloc.dart';
import '../../repositories/auth_repository.dart';

class OtpState {
  final bool loading;
  final bool success;
  final String? error;

  OtpState({
    this.loading = false,
    this.success = false,
    this.error,
  });

  OtpState copyWith({
    bool? loading,
    bool? success,
    String? error,
  }) {
    return OtpState(
      loading: loading ?? this.loading,
      success: success ?? this.success,
      error: error,
    );
  }
}

class OtpCubit extends Cubit<OtpState> {
  final AuthRepository _repository;

  OtpCubit(this._repository) : super(OtpState());

  // Future<void> verifyOtp(String email, String otp) async {
  //   emit(state.copyWith(loading: true, success: false, error: null));
  //   try {
  //     final response = await _repository.verifyOtp(email, otp);
  //
  //     if (response.success) {
  //       emit(state.copyWith(loading: false, success: true));
  //     } else {
  //       emit(state.copyWith(
  //         loading: false,
  //         success: false,
  //         error: response.message ?? "Invalid OTP",
  //       ));
  //     }
  //   } catch (e) {
  //     emit(state.copyWith(
  //       loading: false,
  //       success: false,
  //       error: e.toString(),
  //     ));
  //   }
  // }
  //
  // Future<void> resendOtp(String email) async {
  //   emit(state.copyWith(loading: true, error: null));
  //   try {
  //     final response = await _repository.resendOtp(email);
  //
  //     if (response.success) {
  //       emit(state.copyWith(loading: false));
  //     } else {
  //       emit(state.copyWith(
  //         loading: false,
  //         error: response.message ?? "Failed to resend OTP",
  //       ));
  //     }
  //   } catch (e) {
  //     emit(state.copyWith(
  //       loading: false,
  //       error: e.toString(),
  //     ));
  //   }
  // }
}
