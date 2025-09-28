import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/auth_repository.dart';

class LoginState {
  final bool loading;
  final bool success;
  final String? error;

  const LoginState({this.loading = false, this.success = false, this.error});

  LoginState copyWith({bool? loading, bool? success, String? error}) {
    return LoginState(
      loading: loading ?? this.loading,
      success: success ?? this.success,
      error: error,
    );
  }
}

class LoginCubit extends Cubit<LoginState> {
  final AuthRepository _repository;

  LoginCubit(this._repository) : super(const LoginState());

  Future<void> login(String email, String password) async {
    emit(state.copyWith(loading: true, error: null));
    await Future.delayed(const Duration(seconds: 2));
    // try {
    //   final response = await _repository.login(email, password);
    //   if (response["success"] == true) {
    //     emit(state.copyWith(loading: false, success: true));
    //   }
    // } catch (e) {
    //   emit(state.copyWith(loading: false, error: e.toString()));
    // }
  }
}
