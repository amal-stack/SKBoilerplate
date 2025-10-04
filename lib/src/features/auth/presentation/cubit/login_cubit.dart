import 'dart:async';

import 'package:boilerplate/src/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:boilerplate/src/features/auth/presentation/cubit/state.dart';

import '../../domain/entities/authentication.dart';
import '../../domain/repositories/auth_repository.dart';

class LoginCubit extends AuthCubit<Authentication> {
  LoginCubit(this._repository) {
    _authSubscription = _repository.state.map(AuthOperationSuccess.new).listen(emit);
  }
  final AuthRepository _repository;

  StreamSubscription<AuthOperationState<Authentication>>? _authSubscription;

  Future<void> login(String email, String password) async {
    loading();
    await _repository.login(email, password);
  }

  Future<void> logout() async {
    loading();
    await _repository.logout();
  }

  @override
  Future<void> close() {
    _authSubscription?.cancel();
    return super.close();
  }
}
