import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordState {
  final bool loading;
  final bool success;
  final String? error;
  final String? email;

  const ForgotPasswordState({
    this.loading = false,
    this.success = false,
    this.error,
    this.email,
  });

  ForgotPasswordState copyWith({
    bool? loading,
    bool? success,
    String? error,
    String? email,
  }) {
    return ForgotPasswordState(
      loading: loading ?? this.loading,
      success: success ?? this.success,
      error: error,
      email: email ?? this.email,
    );
  }
}


class ForgotPasswordCubit extends Cubit<ForgotPasswordState> {
  ForgotPasswordCubit() : super(const ForgotPasswordState());

  Future<void> sendResetLink(String email) async {
    emit(state.copyWith(loading: true, error: null));
    // fake API delay
    await Future.delayed(const Duration(seconds: 2));

    if (email == "chintandave3019@gmail.com") {
      emit(state.copyWith(
        loading: false,
        success: true,
        email: email,
      ));
    } else {
      emit(state.copyWith(
        loading: false,
        error: "No account found with this email",
      ));
    }
  }
}
